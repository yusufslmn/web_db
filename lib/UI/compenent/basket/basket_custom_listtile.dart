import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';

class CustomListTileText extends StatelessWidget {
  const CustomListTileText({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 12,
            color: PColors.titleGrey,
            fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        "$price TL",
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}