import 'package:flutter/material.dart';
import 'package:web_db/utility/colors.dart';

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
      leading: Text(
        title,
        style: TextStyle(
            fontSize: 12,
            color: PColors.titleGrey,
            fontWeight: FontWeight.w600),
      ),
      title: Text(
        "${price.toStringAsFixed(2)} TL",
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
