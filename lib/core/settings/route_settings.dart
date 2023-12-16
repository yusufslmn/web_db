import 'package:flutter/material.dart';

Future<dynamic> pushToPage(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
