import 'package:flutter/material.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/UI/view/product_detail.dart';

MaterialPageRoute? routeSettings(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) {
        return const Home();
      });
    case ProductDetail.routeName:
      {
        final args = settings.arguments as ProductDetailsArguments;
        return MaterialPageRoute(
          builder: (context) {
            return ProductDetail(
              product: args.product,
            );
          },
        );
      }
    default:
  }
  assert(false, 'Need to implement ${settings.name}');
  return null;
}
