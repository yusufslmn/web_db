import 'package:flutter/material.dart';

class DateButton extends StatefulWidget {
  const DateButton({super.key, this.onPressed, required this.title});
  final void Function()? onPressed;
  final String title;

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: _elevatedStyle(),
      onPressed: widget.onPressed,
      icon: const Icon(Icons.date_range_rounded),
      label: Text(widget.title),
    );
  }

  ButtonStyle _elevatedStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[700],
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Colors.grey), // Burada çerçeve rengini belirtiyoruz
        borderRadius:
            BorderRadius.circular(6), // İsteğe bağlı olarak kenar yuvarlatma
      ),
    );
  }
}
