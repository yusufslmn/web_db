import 'package:flutter/material.dart';

class LoveAndCompare extends StatelessWidget {
  const LoveAndCompare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
            label: const Text("Beğen")),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.compare_arrows_outlined),
            label: const Text("Karşılaştır")),
      ],
    );
  }
}
