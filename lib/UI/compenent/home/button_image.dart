import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class ButtonImage extends StatelessWidget {
  const ButtonImage({super.key, required this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: context.width(0.03),
      child: IconButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 1.5))),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
