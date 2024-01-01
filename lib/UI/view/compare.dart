import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/UI/compenent/product/image_container.dart';
import 'package:web_db/UI/compenent/product/name.dart';
import 'package:web_db/UI/compenent/product/price.dart';
import 'package:web_db/UI/compenent/product/product_property.dart';
import 'package:web_db/UI/compenent/product/seller_container.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/state/product_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Compare extends ConsumerStatefulWidget {
  const Compare({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompareState();
}

class _CompareState extends ConsumerState<Compare> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                        vertical: 20, horizontal: context.width(0.025)),
                    height: context.height(2),
                    width: context.width(0.95),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ImageContainer(
                                  pictures: ref
                                          .read(productProvider)
                                          .compareList[0]
                                          .pictures ??
                                      []),
                              Expanded(
                                child: Container(
                                    color: PColors.productBackContainer,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomListTile(
                                            name: ref
                                                    .read(productProvider)
                                                    .compareList[0]
                                                    .name ??
                                                "",
                                            textStyle:
                                                CustomTextStyle.nameStyle),
                                        CustomPriceText(
                                            price: ref
                                                .read(productProvider)
                                                .compareList[0]
                                                .price,
                                            campaignPrice: ref
                                                .read(productProvider)
                                                .compareList[0]
                                                .campaignPrice,
                                            commentRating: ref
                                                    .read(productProvider)
                                                    .compareList[0]
                                                    .rating ??
                                                0.0,
                                            commentTotal: ref
                                                    .read(productProvider)
                                                    .compareList[0]
                                                    .commentCount ??
                                                0),
                                        SellerContainer(
                                            seller: ref
                                                    .read(productProvider)
                                                    .compareList[0]
                                                    .brandName ??
                                                "Hepsibunda"),
                                      ],
                                    )),
                              ),
                              ProductProperty(
                                  productDetail: ref
                                          .read(productProvider)
                                          .compareList[0]
                                          .description ??
                                      " "),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 2.5,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ImageContainer(
                                  pictures: ref
                                          .read(productProvider)
                                          .compareList[1]
                                          .pictures ??
                                      []),
                              Expanded(
                                child: Container(
                                    color: PColors.productBackContainer,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomListTile(
                                            name: ref
                                                    .read(productProvider)
                                                    .compareList[1]
                                                    .name ??
                                                "",
                                            textStyle:
                                                CustomTextStyle.nameStyle),
                                        CustomPriceText(
                                            price: ref
                                                .read(productProvider)
                                                .compareList[1]
                                                .price,
                                            campaignPrice: ref
                                                .read(productProvider)
                                                .compareList[1]
                                                .campaignPrice,
                                            commentRating: ref
                                                    .read(productProvider)
                                                    .compareList[1]
                                                    .rating ??
                                                0.0,
                                            commentTotal: ref
                                                    .read(productProvider)
                                                    .compareList[1]
                                                    .commentCount ??
                                                0),
                                        SellerContainer(
                                            seller: ref
                                                    .read(productProvider)
                                                    .compareList[1]
                                                    .brandName ??
                                                "Hepsibunda"),
                                      ],
                                    )),
                              ),
                              ProductProperty(
                                  productDetail: ref
                                          .read(productProvider)
                                          .compareList[1]
                                          .description ??
                                      " "),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("compare")
                                    .doc(IService.basicAuth)
                                    .set({
                                  "id1": ref
                                      .read(productProvider)
                                      .compareList[0]
                                      .id,
                                  "id2": ref
                                      .read(productProvider)
                                      .compareList[1]
                                      .id,
                                }).onError((error, stackTrace) => print(error));
                              },
                              child: Text("kaydet")),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
