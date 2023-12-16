import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';
import 'package:web_db/core/state/basket_state.dart';

class AddToBasket extends ConsumerStatefulWidget {
  const AddToBasket({super.key, required this.product});
  final Product product;
  @override
  ConsumerState<AddToBasket> createState() => _AddToBasketState();
}

class _AddToBasketState extends ConsumerState<AddToBasket> {
  int total = 1;
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
                          if (total > 1) total--;
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
                          total++;
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
                child: Text("$total\nAdet",
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
          child: ElevatedButton(
              onPressed: () {
                ref.read(basketProvider).basket.add(widget.product);
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
