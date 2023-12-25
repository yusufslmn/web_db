import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/basket.dart';
import 'package:web_db/core/service/basket/get_basket_service.dart';

abstract class StateBasket extends ConsumerState<Basket> {
  final String title = "Sepetim";
  int total = 1;
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    fetchBasketItem();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
}

class BasketNotifier extends ChangeNotifier {}

final basketProvider = ChangeNotifierProvider<BasketNotifier>((ref) {
  return BasketNotifier();
});
