import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:web_db/u%C4%B1/compenent/appBar/top_app_bar.dart';
import 'package:web_db/u%C4%B1/compenent/home/product_item.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:web_db/model/product/showroom_product_model.dart';
import 'package:web_db/service/category/get_category_product.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.id, required this.name});
  final int id;
  final String name;
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ScrollController _scrollController = ScrollController();

  bool isCampaign = false;
  bool isLoading = false;
  List<ProductItem> campaingList = [];
  List<ProductItem> allList = [];

  void changeFilter() {
    setState(() {
      isCampaign = !isCampaign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopAppBar(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                widget.name,
                style: const TextStyle(
                    color: PColors.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: PColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: changeFilter,
                child: const Text(
                  "Kampanyalı ürünler",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            FutureBuilder<List<ShowroomProduct>>(
              future: fetchCategoryProduct(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (ShowroomProduct e in snapshot.data!) {
                    if (e.campaignPrice != null) {
                      campaingList.add(ProductItem(product: e));
                    }
                    allList.add(ProductItem(product: e));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: snapshot.data!.length * context.height(0.4),
                      child: DesktopScrollbar(
                          controller: _scrollController,
                          thumbColor: Colors.black,
                          radius: const Radius.circular(8),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, childAspectRatio: 0.6),
                            controller: _scrollController,
                            cacheExtent: 500,
                            itemCount: isCampaign
                                ? campaingList.length
                                : allList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => isCampaign
                                ? campaingList[index]
                                : allList[index],
                          )),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      )),
    );
  }
}
