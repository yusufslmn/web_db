import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/u%C4%B1/compenent/appBar/top_app_bar.dart';
import 'package:web_db/u%C4%B1/compenent/product/custom_text_style.dart';
import 'package:web_db/u%C4%B1/compenent/product/image_container.dart';
import 'package:web_db/u%C4%B1/compenent/product/name.dart';
import 'package:web_db/u%C4%B1/compenent/product/price.dart';
import 'package:web_db/u%C4%B1/compenent/product/product_property.dart';
import 'package:web_db/u%C4%B1/compenent/product/seller_container.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:web_db/model/product/product_detail_model.dart';
import 'package:web_db/service/product/get_product_detail.dart';
import 'package:web_db/service/service.dart';
import 'package:web_db/settings/route_settings.dart';
import 'package:web_db/state/product_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Compare extends ConsumerStatefulWidget {
  const Compare(
      {super.key, required this.isShow, required this.id1, required this.id2});
  final int id1;
  final int id2;
  final bool isShow;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompareState();
}

class _CompareState extends ConsumerState<Compare> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  ProductDetailModel? model1;
  ProductDetailModel? model2;
  void getProduct() async {
    changeLoading();
    model1 = await fetchProductDetail(widget.id1);
    model2 = await fetchProductDetail(widget.id2);
    changeLoading();
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TopAppBar(),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
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
                                      pictures: model1!.pictures ?? []),
                                  Expanded(
                                    child: Container(
                                        color: PColors.productBackContainer,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomListTile(
                                                name: model1!.name ?? "",
                                                textStyle:
                                                    CustomTextStyle.nameStyle),
                                            CustomPriceText(
                                                price: model1!.price,
                                                campaignPrice:
                                                    model1!.campaignPrice,
                                                commentRating:
                                                    model1!.rating ?? 0.0,
                                                commentTotal:
                                                    model1!.commentCount ?? 0),
                                            SellerContainer(
                                                seller: model1!.brandName ??
                                                    "Hepsibunda"),
                                          ],
                                        )),
                                  ),
                                  ProductProperty(
                                      productDetail:
                                          model1!.description ?? " "),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.black,
                              width: context.width(0.004),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  ImageContainer(
                                      pictures: model2!.pictures ?? []),
                                  Expanded(
                                    child: Container(
                                        color: PColors.productBackContainer,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomListTile(
                                                name: model2!.name ?? "",
                                                textStyle:
                                                    CustomTextStyle.nameStyle),
                                            CustomPriceText(
                                                price: model2!.price,
                                                campaignPrice:
                                                    model2!.campaignPrice,
                                                commentRating:
                                                    model2!.rating ?? 0.0,
                                                commentTotal:
                                                    model2!.commentCount ?? 0),
                                            SellerContainer(
                                                seller: model2!.brandName ??
                                                    "Hepsibunda"),
                                          ],
                                        )),
                                  ),
                                  ProductProperty(
                                      productDetail:
                                          model2!.description ?? " "),
                                ],
                              ),
                            ),
                          ],
                        )),
                widget.isShow
                    ? Center(
                        child: SizedBox(
                          width: context.width(0.09),
                          height: context.height(0.06),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () async {
                                changeLoading();
                                await FirebaseFirestore.instance
                                    .collection("compare")
                                    .doc()
                                    .set({
                                  "auth": IService.basicAuth,
                                  "id1": widget.id1,
                                  "name1": model1!.name,
                                  "id2": widget.id2,
                                  "name2": model2!.name,
                                }).then((value) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          "Karşılaştırma kaydedildi"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        Routes.homeRoute,
                                                        (route) => false),
                                            child: const Text("Kaydet"))
                                      ],
                                    ),
                                  );
                                });
                                ref.read(productProvider).compareList.clear();
                                changeLoading();
                              },
                              child: const Text(
                                "Kaydet",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
