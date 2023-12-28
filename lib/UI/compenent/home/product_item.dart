import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/home/add_basket_button.dart';
import 'package:web_db/UI/compenent/home/rating.dart';
import 'package:web_db/UI/compenent/home/top_seller.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/showroom_product_model.dart';
import 'package:web_db/core/settings/route_settings.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });
  final ShowroomProduct product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushToPage(context, ProductDetail(id: product.id ?? 0));
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        width: context.width(0.12),
        height: context.height(0.5),
        child: Column(
          children: [
            Expanded(
                flex: 7,
                child: PageView.builder(
                  itemCount: product.pictures!.length,
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: product.pictures![index],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
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
            Expanded(
              flex: 2,
              child: Rating(
                  rating: product.rating ?? 0.0,
                  totalComment: product.commentCount ?? 0),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: PaddingCustom.symetric,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${product.price ?? 0} TL",
                        style: TextStyle(
                          decoration: product.campaignPrice == null
                              ? null
                              : TextDecoration.lineThrough,
                          decorationThickness:
                              product.campaignPrice == null ? null : 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    product.campaignPrice == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "${product.campaignPrice ?? 0} TL",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3, child: AddBasketButton(productId: product.id ?? 0)),
          ],
        ),
      ),
    );
  }
}
