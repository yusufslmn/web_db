import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.name, this.textStyle});

  final String? name;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(name ?? "Error"), titleTextStyle: textStyle);
  }
}
