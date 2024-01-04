import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, required this.rating, required this.totalComment});
  final double rating;
  final int totalComment;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: RatingBarIndicator(
                direction: Axis.horizontal,
                rating: rating,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 5,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                '$totalComment',
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
