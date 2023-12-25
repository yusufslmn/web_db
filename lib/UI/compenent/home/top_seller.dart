import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/home/product_item.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/showroom_product_model.dart';
import 'package:web_db/core/service/product/get_showroom_products.dart';

class TopSellerProducts extends StatefulWidget {
  final ScrollController topSellerController;

  const TopSellerProducts({
    super.key,
    required this.topSellerController,
  });

  @override
  State<TopSellerProducts> createState() => _TopSellerProductsState();
}

class _TopSellerProductsState extends State<TopSellerProducts> {
  @override
  void initState() {
    fetchShowroomProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(1),
      height: context.height(1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.width(0.8),
            height: context.height(0.1),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(
                "Herkes bu ürünlerin peşinde",
                style: GoogleFonts.roboto(
                    color: PColors.boldGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Şu an da kampanyada olanlar",
                style: GoogleFonts.roboto(
                    color: PColors.boldGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: context.width(0.76),
            height: context.height(1.4),
            child: DesktopScrollbar(
              controller: widget.topSellerController,
              thumbColor: Colors.black,
              radius: const Radius.circular(8),
              child: FutureBuilder<List<ShowroomProduct>>(
                future: fetchShowroomProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, childAspectRatio: 0.6),
                      controller: widget.topSellerController,
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => ProductItem(
                        index: index,
                        product: snapshot.data![index],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaddingCustom {
  static const EdgeInsets symetric = EdgeInsets.symmetric(horizontal: 8.0);
}
