import 'package:flutter/material.dart';

class ProductProperty extends StatefulWidget {
  const ProductProperty({super.key});

  @override
  State<ProductProperty> createState() => _ProductPropertyState();
}

class _ProductPropertyState extends State<ProductProperty> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          title: Text("data"),
        ),
        ListTile(
          title: Text("data"),
        ),
        ListTile(
          title: Text("data"),
        ),
        ListTile(
          title: Text("data"),
        )
      ],
    );
  }
}
