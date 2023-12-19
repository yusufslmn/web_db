import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/core/model/product_model.dart';

abstract class ProductState extends ConsumerState<ProductDetail> {
  Product product = Product();
  ScrollController controller = ScrollController();
  PageController bottomTabController = PageController();
  int commentTotal = 4;
  String seller = "Hepsiburada";
  String temp = "default";
  double commentRating = 4;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }
}

// ignore: constant_identifier_names
enum ColorsName { Mavi, Yesil, Mor }

class ProductNotifier extends ChangeNotifier {
  int indexPage = 0;
  String color = "Mavi";
  List<Color?> colors = [Colors.blue, Colors.green, Colors.deepPurple];
  List<Product>? compareList;
  PageController pageController = PageController();

  void nextImage() async {
    await pageController.nextPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
    notifyListeners();
  }

  void preImage() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
    notifyListeners();
  }
}

final productProvider = ChangeNotifierProvider<ProductNotifier>((ref) {
  return ProductNotifier();
});
