import 'package:flutter/material.dart';
import 'package:web_db/core/model/add_basket_modal.dart';
import 'package:web_db/core/service/basket/add_basket_service.dart';
import '../../../core/Utility/colors.dart';

class AddBasketButton extends StatefulWidget {
  const AddBasketButton({super.key, required this.productId});
  final int productId;

  @override
  State<AddBasketButton> createState() => _AddBasketButtonState();
}

class _AddBasketButtonState extends State<AddBasketButton> {
  final int quantity = 1;

  bool isLoading = false;
  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: PColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () async {
                  AddBasketModel model = AddBasketModel(
                      productId: widget.productId, quantity: quantity);
                  _changeLoading();
                  await addToBasket(model).then((value) {
                    if (value) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Alışverişe Devam et"))
                                ],
                                title: const Text("Ürün Sepete Eklendi"),
                              ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Tekrar Deneyiniz"))
                                ],
                                title: const Text("Ürün Sepete Eklenemedi"),
                              ));
                    }
                  });
                  _changeLoading();
                },
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(color: Colors.white),
                )),
          );
  }
}
