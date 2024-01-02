import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/basket/basket.dart';

abstract class StateBasket extends ConsumerState<Basket> {
  final String title = "Sepetim";
  String? couponCode;
  double? discount;
  final ExpansionTileController expansionTileController =
      ExpansionTileController();
  final ScrollController controller = ScrollController();
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
