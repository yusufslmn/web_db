import 'package:flutter/material.dart';
import 'package:web_db/UI/view/home/home.dart';

abstract class StateHome extends State<Home> {
  final ScrollController topSellerController = ScrollController();

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int indexPage = 0;

  void nextPage() async {
    await pageController.nextPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }

  void prePage() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }
}
