import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/basket.dart';
import 'package:web_db/core/service/basket/get_basket_service.dart';

abstract class StateBasket extends ConsumerState<Basket> {
  final String title = "Sepetim";

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
}

class BasketNotifier extends ChangeNotifier {}

final basketProvider = ChangeNotifierProvider<BasketNotifier>((ref) {
  return BasketNotifier();
});
