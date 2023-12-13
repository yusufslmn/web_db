import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';

class RatingProduct extends StatelessWidget {
  const RatingProduct({
    super.key,
    required this.commentRating,
  });
  final double commentRating;

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "4.7",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_half_outlined,
          color: PColors.mainColor,
        ),
      ],
    );
  }
}
