// ignore_for_file: avoid_print

import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/u%C4%B1/compenent/appBar/top_app_bar.dart';
import 'package:web_db/u%C4%B1/compenent/product/add_to_basket.dart';
import 'package:web_db/u%C4%B1/compenent/product/campaign.dart';
import 'package:web_db/u%C4%B1/compenent/product/custom_text_style.dart';
import 'package:web_db/u%C4%B1/compenent/product/image_container.dart';
import 'package:web_db/u%C4%B1/compenent/product/name.dart';
import 'package:web_db/u%C4%B1/compenent/product/price.dart';
import 'package:web_db/u%C4%B1/compenent/product/seller_container.dart';
import 'package:web_db/u%C4%B1/view/product/compare.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:web_db/settings/route_settings.dart';
import 'package:web_db/state/product_state.dart';
import '../../compenent/product/comments.dart';
import '../../compenent/product/product_property.dart';

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({super.key, required this.id});
  final int id;

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ProductState with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              ref.watch(productProvider).indexPage = 0;
            },
            child: Scaffold(
              body: SafeArea(
                child: CrossScroll(
                  verticalBar: const CrossScrollBar(),
                  horizontalBar: const CrossScrollBar(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopAppBar(),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: context.width(0.15)),
                          width: context.width(0.7),
                          height: context.height(0.8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              ImageContainer(
                                  pictures: productDetailModel?.pictures ?? []),
                              Expanded(
                                child: Container(
                                    color: PColors.productBackContainer,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomListTile(
                                            name:
                                                productDetailModel?.name ?? "",
                                            textStyle:
                                                CustomTextStyle.nameStyle),
                                        CustomPriceText(
                                            price: productDetailModel!.price,
                                            campaignPrice: productDetailModel!
                                                .campaignPrice,
                                            commentRating:
                                                productDetailModel!.rating ??
                                                    0.0,
                                            commentTotal: productDetailModel!
                                                    .commentCount ??
                                                0),
                                        SellerContainer(
                                            seller:
                                                productDetailModel?.brandName ??
                                                    "Hepsibunda"),
                                        SizedBox(
                                          height: context.height(0.08),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: productDetailModel!
                                                    .attributes?.length ??
                                                0,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: DropdownButton(
                                                value: attributesId[index],
                                                dropdownColor: PColors
                                                    .productBackContainer,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                hint: Text(productDetailModel!
                                                        .attributes?[index]
                                                        .name ??
                                                    " "),
                                                onChanged: (value) {
                                                  setState(() {
                                                    attributesId[index] = value;
                                                  });
                                                },
                                                items: productDetailModel!
                                                    .attributes?[index].items!
                                                    .map((v) =>
                                                        DropdownMenuItem(
                                                            value: v.id,
                                                            child: Text(
                                                                v.name ?? " ")))
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        AddToBasket(
                                            attributes: attributesId,
                                            productId:
                                                productDetailModel!.id ?? 0),
                                        const Spacer(),
                                        const Divider(),
                                        Row(
                                          children: [
                                            TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .favorite_border_outlined),
                                                label: const Text("Beğen")),
                                            TextButton.icon(
                                                onPressed: () {
                                                  if (ref
                                                          .read(productProvider)
                                                          .compareList
                                                          .length <=
                                                      2) {
                                                    if (!(ref
                                                        .read(productProvider)
                                                        .compareList
                                                        .contains(
                                                            productDetailModel!
                                                                .id))) {
                                                      ref
                                                          .read(productProvider)
                                                          .compareList
                                                          .add(
                                                              productDetailModel!
                                                                      .id ??
                                                                  0);
                                                      setState(() {});
                                                      if (ref
                                                              .read(
                                                                  productProvider)
                                                              .compareList
                                                              .length ==
                                                          2) {
                                                        pushToPage(
                                                            context,
                                                            Compare(
                                                              isShow: true,
                                                              id1: ref
                                                                  .read(
                                                                      productProvider)
                                                                  .compareList[0],
                                                              id2: ref
                                                                  .read(
                                                                      productProvider)
                                                                  .compareList[1],
                                                            ));
                                                      }
                                                    }
                                                  }
                                                },
                                                icon: const Icon(Icons
                                                    .compare_arrows_outlined),
                                                label:
                                                    const Text("Karşılaştır")),
                                            Text(
                                                "${ref.watch(productProvider).compareList.length}")
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          )),
                      Container(
                        width: context.width(0.4),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: context.width(0.15)),
                        child: TabBar(
                            onTap: (value) {
                              bottomTabController.animateToPage(value,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.linear);
                            },
                            controller: TabController(vsync: this, length: 3),
                            tabs: const [
                              Text("Yorumlar"),
                              Text("Ürün Açıklaması"),
                              Text("Kampanyalar"),
                            ]),
                      ),
                      Container(
                        width: context.width(0.7),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: context.width(0.15)),
                        height: context.height(1.5),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: bottomTabController,
                          children: [
                            Comments(productId: widget.id),
                            ProductProperty(
                              productDetail:
                                  productDetailModel?.description ?? " ",
                            ),
                            const Campaign(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
