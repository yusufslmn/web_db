import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
          size: 20,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
          size: 20,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
          size: 20,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
          size: 20,
        ),
        Icon(
          Icons.star_half_outlined,
          color: PColors.mainColor,
          size: 20,
        ),
        Text(
          "10000",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
