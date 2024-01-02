import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/appBar/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/product_item.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/showroom_product_model.dart';
import 'package:web_db/core/service/category/get_category_product.dart';

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
                            itemCount: snapshot.data!.length,
                            cacheExtent: 500,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => isCampaign
                                ? (snapshot.data![index].campaignPrice != null
                                    ? ProductItem(
                                        product: snapshot.data![index])
                                    : null)
                                : ProductItem(product: snapshot.data![index]),
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
