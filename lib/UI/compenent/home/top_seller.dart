import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/home/product_item.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class TopSellerProducts extends StatelessWidget {
  final ScrollController topSellerController;

  const TopSellerProducts({
    super.key,
    required this.topSellerController,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(1),
      height: context.height(0.5),
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
                "Şu an çok satılıyor",
                style: GoogleFonts.roboto(
                    color: PColors.boldGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: context.width(0.76),
            height: context.height(0.4),
            child: DesktopScrollbar(
              controller: topSellerController,
              thumbColor: Colors.black,
              radius: const Radius.circular(8),
              child: ListView.builder(
                controller: topSellerController,
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ProductItem(
                  index: index,
                  product: productList[index],
                ),
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
