import 'package:flutter/material.dart';

Future<dynamic> push(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
