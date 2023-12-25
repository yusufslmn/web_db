import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingProduct extends StatelessWidget {
  const RatingProduct({
    super.key,
    required this.commentRating,
  });
  final double commentRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: commentRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 5,
      ),
      onRatingUpdate: (double value) {},
    );
  }
}
