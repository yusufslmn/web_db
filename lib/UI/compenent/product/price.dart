import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/UI/compenent/product/product_rating.dart';
import 'package:web_db/core/model/product_model.dart';

class CustomPriceText extends StatelessWidget {
  const CustomPriceText({
    super.key,
    required this.product,
    required this.commentRating,
    required this.commentTotal,
  });

  final Product product;
  final double commentRating;
  final int commentTotal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${product.price ?? 00.00},00 TL"),
      titleTextStyle: CustomTextStyle.priceStyle,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RatingProduct(
            commentRating: commentRating,
          ),
          Text("$commentTotal değerlendirme",
              style: CustomTextStyle.commentStyle)
        ],
      ),
    );
  }
}
