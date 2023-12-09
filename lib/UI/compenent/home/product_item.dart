import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/home/add_basket_button.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/home/rating.dart';
import 'package:web_db/UI/compenent/home/top_seller.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.index});
  final Product product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: ProductDetailsArguments(product),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        width: context.width(0.12),
        height: context.height(0.4),
        child: Column(
          children: [
            Expanded(flex: 7, child: Image.network(productImages[index])),
            Expanded(
              flex: 2,
              child: Container(
                margin: PaddingCustom.symetric,
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  softWrap: true,
                  product.name ?? "error",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Padding(
                padding: PaddingCustom.symetric,
                child: Rating(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: PaddingCustom.symetric,
                child: Text(
                  "${product.price ?? 0} TL",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Expanded(flex: 3, child: AddBasketButton()),
          ],
        ),
      ),
    );
  }
}
