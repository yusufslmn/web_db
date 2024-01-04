import 'package:flutter/material.dart';

class ProductProperty extends StatelessWidget {
  const ProductProperty({super.key, required this.productDetail});
  final String productDetail;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(productDetail),
        )
      ],
    );
  }
}
