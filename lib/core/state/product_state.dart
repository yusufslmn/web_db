import 'package:flutter/material.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/core/model/product_model.dart';

abstract class ProductState extends State<ProductDetail> {
  Product product = Product();
  ScrollController controller = ScrollController();
  PageController pageController = PageController();
  PageController bottomTabController = PageController();
  int indexPage = 0;
  int commentTotal = 4;
  int total = 1;
  String seller = "Hepsiburada";
  String color = "Mavi";
  String temp = "default";
  double commentRating = 4;
  List<Color?> colors = [Colors.blue, Colors.green, Colors.deepPurple];

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  void nextImage() async {
    await pageController.nextPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }

  void preImage() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }
}

// ignore: constant_identifier_names
enum ColorsName { Mavi, Yesil, Mor }
