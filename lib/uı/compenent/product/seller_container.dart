import 'package:flutter/material.dart';
import 'package:web_db/u%C4%B1/compenent/product/custom_text_style.dart';
import 'package:web_db/utility/screen_size.dart';

class SellerContainer extends StatelessWidget {
  const SellerContainer({
    super.key,
    required this.seller,
  });

  final String seller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: context.width(0.15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200)),
      child: ListTile(
        tileColor: Colors.pink,
        selectedTileColor: Colors.pink,
        selectedColor: Colors.pink,
        selected: true,
        enabled: true,
        leading: Text(
          "Satıcı:",
          style: CustomTextStyle.sellerStyle,
        ),
        title: Text(
          seller,
          style: CustomTextStyle.sellerStyleBlue,
        ),
      ),
    );
  }
}
