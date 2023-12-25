import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/UI/compenent/product/product_rating.dart';

class CustomPriceText extends StatelessWidget {
  const CustomPriceText({
    super.key,
    required this.price,
    required this.campaignPrice,
    required this.commentRating,
    required this.commentTotal,
  });

  final double? price;
  final double? campaignPrice;
  final double commentRating;
  final int commentTotal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${price ?? 0} TL",
              style: TextStyle(
                decoration:
                    campaignPrice == null ? null : TextDecoration.lineThrough,
                decorationThickness: campaignPrice == null ? null : 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          campaignPrice == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${campaignPrice ?? 0} TL",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
        ],
      ),
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
