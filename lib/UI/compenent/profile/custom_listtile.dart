import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
  });
  final String leading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: PColors.mainColor),
            borderRadius: BorderRadius.circular(16)),
        leading: Text(
          leading,
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
