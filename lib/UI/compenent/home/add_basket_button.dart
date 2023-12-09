import 'package:flutter/material.dart';

import '../../../core/Utility/colors.dart';

class AddBasketButton extends StatelessWidget {
  const AddBasketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: PColors.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          onPressed: () {},
          child: const Text(
            "Sepete Ekle",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
