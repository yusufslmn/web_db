import 'package:flutter/material.dart';

Future<dynamic> pushToPage(BuildContext context, Widget page) =>
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
Future<dynamic> pushReplacement(BuildContext context, Widget page) =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => page,
    ));
Future<dynamic> pushNamed(BuildContext context, String pageRoute) =>
    Navigator.of(context).pushNamed(pageRoute);

class Routes {
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String basketRoute = "/basket";
  static const String profileRoute = "/profile";
  static const String registerRoute = "/register";
}
