import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/basket.dart';
import 'package:web_db/core/model/product_model.dart';

abstract class StateBasket extends ConsumerState<Basket> {
  final String title = "Sepetim";
  int total = 1;
  String? validate(String? value) {
    if (value != "baran") {
      return "giren baran değil";
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
}

class BasketNotifier extends ChangeNotifier {
  List<Product> basket = [
    Product(
        id: 1,
        brandId: 12,
        categoryId: 12,
        description: "loremloremloremlorem",
        name: "lorem lorem lorem lorem 1",
        price: 40.00,
        sellerId: 2,
        stockQuantity: 150),
    Product(
        id: 1,
        brandId: 12,
        categoryId: 12,
        description: "loremloremloremlorem",
        name: "lorem lorem lorem lorem 2",
        price: 50.00,
        sellerId: 2,
        stockQuantity: 150),
  ];
  double toplam() {
    double toplam = 0.0;
    for (int i = 0; i < basket.length; i++) {
      toplam += basket[i].price!;
    }
    return toplam;
  }
}

final basketProvider = ChangeNotifierProvider<BasketNotifier>((ref) {
  return BasketNotifier();
});
