import 'package:flutter/material.dart';

BoxDecoration decorationContainer() {
  return BoxDecoration(
      color: Colors.orange,
      gradient: LinearGradient(colors: [
        Colors.orange.shade500,
        Colors.orange.shade600,
        Colors.orange.shade700,
        Colors.orange.shade800,
        Colors.orange.shade900,
      ], tileMode: TileMode.repeated));
}
