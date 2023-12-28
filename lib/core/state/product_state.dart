import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/core/model/product/product_detail_model.dart';
import 'package:web_db/core/model/product/showroom_product_model.dart';
import 'package:web_db/core/service/product/get_product_detail.dart';

abstract class ProductState extends ConsumerState<ProductDetail> {
  ScrollController controller = ScrollController();
  PageController bottomTabController = PageController();
  String temp = "default";
  bool isLoading = false;
  ProductDetailModel? productDetailModel;
  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchProduct(int id) async {
    _changeLoading();
    productDetailModel = await fetchProductDetail(id);
    _changeLoading();
  }

  @override
  void initState() {
    fetchProduct(widget.id);

    super.initState();
  }
}

// ignore: constant_identifier_names
enum ColorsName { Mavi, Yesil, Mor }

class ProductNotifier extends ChangeNotifier {
  int indexPage = 0;
  String color = "Mavi";
  List<Color?> colors = [Colors.blue, Colors.green, Colors.deepPurple];
  List<ShowroomProduct>? compareList;
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
