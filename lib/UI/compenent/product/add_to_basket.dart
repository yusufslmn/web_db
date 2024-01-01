import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/basket/add_basket_modal.dart';
import 'package:web_db/core/service/basket/add_basket_service.dart';

class AddToBasket extends ConsumerStatefulWidget {
  const AddToBasket(
      {super.key, required this.productId, required this.attributes});
  final int productId;
  final List<int?> attributes;
  @override
  ConsumerState<AddToBasket> createState() => _AddToBasketState();
}

class _AddToBasketState extends ConsumerState<AddToBasket> {
  bool isLoading = false;
  AddBasketModel addToBasketItem = AddBasketModel();

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: context.width(0.06),
              height: context.height(0.05),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
                left: 0,
                child: SizedBox(
                  width: context.width(0.0185),
                  child: IconButton(
                      style: IconButton.styleFrom(
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4)))),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      icon: Icon(
                        Icons.horizontal_rule_rounded,
                        size: context.width(0.01),
                      )),
                )),
            Positioned(
                right: 0,
                child: SizedBox(
                  width: context.width(0.0185),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      style: IconButton.styleFrom(
                          elevation: 0.0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4)))),
                      icon: Icon(
                        Icons.add,
                        size: context.width(0.01),
                      )),
                )),
            Positioned(
              left: context.width(0.0185),
              top: context.height(0.0025),
              child: Container(
                color: Colors.white,
                width: context.width(0.023),
                height: context.height(0.045),
                alignment: Alignment.center,
                child: Text("$quantity\nAdet",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: context.width(0.1),
          height: context.height(0.05),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    _changeLoading();
                    addToBasketItem = AddBasketModel(
                      productId: widget.productId,
                      attributeItemIds: widget.attributes,
                      quantity: quantity,
                    );
                    await addToBasket(addToBasketItem).then((value) {
                      if (value) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child:
                                            const Text("Alışverişe Devam et"))
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
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      backgroundColor: PColors.mainColor),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        "Sepete Ekle",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
        ),
      ],
    );
  }
}
