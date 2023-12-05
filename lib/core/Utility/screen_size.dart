import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double width(double val) => (MediaQuery.of(this).size.width) * val;
  double height(double val) => (MediaQuery.of(this).size.height) * val;
}
