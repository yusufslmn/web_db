import 'package:flutter/material.dart';
import 'package:web_db/utility/screen_size.dart';

class TopRowsColors extends StatelessWidget {
  const TopRowsColors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.blue,
          height: context.height(0.01),
          width: context.width(0.25),
        ),
        Container(
          color: Colors.grey,
          height: context.height(0.01),
          width: context.width(0.15),
        ),
        Container(
          color: Colors.orange,
          height: context.height(0.01),
          width: context.width(0.2),
        ),
        Container(
          color: Colors.green,
          height: context.height(0.01),
          width: context.width(0.15),
        ),
        Container(
          color: Colors.red,
          height: context.height(0.01),
          width: context.width(0.15),
        ),
        Container(
          color: Colors.yellow,
          height: context.height(0.01),
          width: context.width(0.1),
        ),
      ],
    );
  }
}
