import 'package:flutter/material.dart';

Future<dynamic> pushToPage(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
Future<dynamic> pushReplacement(BuildContext context, Widget page) =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => page,
    ));
