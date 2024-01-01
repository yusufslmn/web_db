// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/basket/basket_custom_listtile.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/view/buying.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/basket/basket_model.dart';
import 'package:web_db/core/model/basket/uptade_quantity.dart';
import 'package:web_db/core/model/coupon/coupon_model.dart';
import 'package:web_db/core/service/basket/empty_basket_service.dart';
import 'package:web_db/core/service/basket/get_basket_service.dart';
import 'package:web_db/core/service/basket/uptade_quantity.dart';
import 'package:web_db/core/service/coupon/get_user_coupon.dart';
import 'package:web_db/core/settings/route_settings.dart';
import 'package:web_db/core/state/basket_state.dart';

class Basket extends ConsumerStatefulWidget {
  const Basket({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasketState();
}

class _BasketState extends StateBasket {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.productBackContainer,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopAppBar(),
            FutureBuilder<BasketModal>(
              future: fetchBasketItem(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BasketTop(
                        title: title,
                        totalItemCount: snapshot.data!.totalItemCount ?? 0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.width(0.15)),
                        width: context.width(0.7),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ExpansionTile(
                                          collapsedBackgroundColor:
                                              Colors.white,
                                          backgroundColor: Colors.white,
                                          controller: expansionTileController,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                  color: PColors
                                                      .productBackContainer)),
                                          leading: TextButton.icon(
                                              onPressed: () {
                                                if (!expansionTileController
                                                    .isExpanded) {
                                                  expansionTileController
                                                      .expand();
                                                } else {
                                                  expansionTileController
                                                      .collapse();
                                                }
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
                                                color: PColors.mainColor,
                                              ),
                                              label: const Text(
                                                "Kupon Ekle",
                                                style: TextStyle(
                                                    color: PColors.mainColor),
                                              )),
                                          title: const SizedBox.shrink(),
                                          children: [
                                            FutureBuilder<List<CouponModel>>(
                                              future: getUserCoupons(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                      height:
                                                          context.height(0.25),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Scrollbar(
                                                        controller: controller,
                                                        child: ListView.builder(
                                                          itemCount: snapshot
                                                                  .data
                                                                  ?.length ??
                                                              0,
                                                          controller:
                                                              controller,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8),
                                                            width: context
                                                                .width(0.1),
                                                            height: context
                                                                .height(0.25),
                                                            child: Card(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    color: PColors
                                                                        .mainColor,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "${snapshot.data![index].code}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          backgroundColor: PColors
                                                                              .mainColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Her üründe geçerli ${snapshot.data![index].discount}TL",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Son  ${snapshot.data![index].remainedQuantity ?? 1} adet",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: snapshot.data?[index].isAvailable ==
                                                                            true
                                                                        ? ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: PColors.mainColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                couponCode = snapshot.data?[index].code;
                                                                                discount = snapshot.data![index].discount;
                                                                              });
                                                                            },
                                                                            child: const Text(
                                                                              "Kuponu Kullan",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ))
                                                                        : ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 209, 150, 114), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                                                                            onPressed: () {},
                                                                            child: const Text(
                                                                              "Kupon Kullanılamaz",
                                                                              style: TextStyle(color: Colors.white),
                                                                            )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      '${snapshot.error}');
                                                }

                                                // By default, show a loading spinner.
                                                return const CircularProgressIndicator();
                                              },
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: context.height(0.8),
                                      child: ListView.builder(
                                        itemCount:
                                            snapshot.data?.items?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              color: Colors.white,
                                              height: context.height(0.25),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: ListTile(
                                                      leading:
                                                          const Text("Satıcı:"),
                                                      title: Text(snapshot
                                                              .data!
                                                              .items![index]
                                                              .brandName ??
                                                          ""),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: PColors
                                                        .productBackContainer,
                                                  ),
                                                  const Expanded(
                                                    flex: 2,
                                                    child: ListTile(
                                                      leading: Icon(
                                                          Icons.local_shipping,
                                                          size: 20),
                                                      title: Text(
                                                          "Tahmini 20 Aralık Çarşamba kapında"),
                                                      titleTextStyle: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 6,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16.0),
                                                              child: Image.network(snapshot
                                                                      .data
                                                                      ?.items?[
                                                                          index]
                                                                      .pictures
                                                                      ?.first ??
                                                                  ""),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 8,
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  subtitle: Text(snapshot
                                                                          .data!
                                                                          .items![
                                                                              index]
                                                                          .attributes!
                                                                          .isEmpty
                                                                      ? " "
                                                                      : snapshot
                                                                          .data!
                                                                          .items![
                                                                              index]
                                                                          .attributes
                                                                          .toString()),
                                                                  title: Text(snapshot
                                                                          .data!
                                                                          .items![
                                                                              index]
                                                                          .productName ??
                                                                      ""),
                                                                ),
                                                                ListTile(
                                                                  leading:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white)),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              UptadeQuantity addToBasketItem = UptadeQuantity(
                                                                                productId: snapshot.data?.items?[index].productId ?? 0,
                                                                                quantity: (snapshot.data?.items?[index].quantity ?? 0) - 1,
                                                                              );
                                                                              await uptadeQuantity(addToBasketItem);
                                                                              setState(() {});
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.remove,
                                                                              color: PColors.mainColor,
                                                                            )),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            "${snapshot.data?.items?[index].quantity ?? 0}",
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              UptadeQuantity addToBasketItem = UptadeQuantity(
                                                                                productId: snapshot.data?.items?[index].productId ?? 0,
                                                                                quantity: (snapshot.data?.items?[index].quantity ?? 0) + 1,
                                                                              );
                                                                              await uptadeQuantity(addToBasketItem);
                                                                              setState(() {});
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.add,
                                                                              color: PColors.mainColor,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  trailing: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        "${snapshot.data?.items?[index].price?.toStringAsFixed(2) ?? 0.00} TL",
                                                                        style: TextStyle(
                                                                            decoration: snapshot.data!.items![index].campaignPrice != null
                                                                                ? TextDecoration.lineThrough
                                                                                : null,
                                                                            decorationThickness: 2,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      snapshot.data!.items![index].campaignPrice !=
                                                                              null
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                              child: Text(
                                                                                "${snapshot.data?.items?[index].campaignPrice?.toStringAsFixed(2) ?? 0} TL",
                                                                                style: const TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                          : const SizedBox
                                                                              .shrink(),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: BasketTotalContainer(
                                    couponCode: couponCode,
                                    discount: discount,
                                    totalCampaignPrice:
                                        snapshot.data?.totalCampaignPrice ?? 0,
                                    totalItemCount:
                                        snapshot.data?.totalItemCount ?? 0,
                                    totalPrice: snapshot.data?.totalPrice ?? 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ],
        ),
      )),
    );
  }
}

class BasketTotalContainer extends StatelessWidget {
  const BasketTotalContainer(
      {super.key,
      required this.totalCampaignPrice,
      required this.totalItemCount,
      required this.totalPrice,
      required this.discount,
      required this.couponCode});
  final double? totalCampaignPrice;
  final int? totalItemCount;
  final double? totalPrice;
  final String? couponCode;
  final double? discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height(0.5),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SEPETTEKİ ÜRÜNLER ($totalItemCount)",
            style: const TextStyle(
                color: PColors.mainColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${(totalPrice ?? 0).toStringAsFixed(2)} TL",
                  style: TextStyle(
                      decorationThickness: 2,
                      decoration: totalCampaignPrice == null
                          ? null
                          : TextDecoration.lineThrough,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              totalCampaignPrice == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${(totalCampaignPrice ?? 0).toStringAsFixed(2)} TL",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              discount == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "- ${(discount ?? 0).toStringAsFixed(2)} TL",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 53, 154, 205),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
          const Spacer(
            flex: 8,
          ),
          SizedBox(
            height: context.height(0.06),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: PColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => pushToPage(
                  context,
                  Buying(
                    totalItemCount: totalItemCount,
                    totalPrice: totalPrice,
                    totalCampaignPrice: totalCampaignPrice,
                    couponCode: couponCode,
                    discount: discount,
                  )),
              child: Text(
                "Alışverişi tamamla",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.height(0.0150),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          CustomListTileText(
            price: totalCampaignPrice ?? (totalPrice ?? 0),
            title: "Ürünler:",
          ),
          const CustomListTileText(
            price: 29.99,
            title: "Kargo:",
          ),
          const Divider(),
          CustomListTileText(
              title: 'Toplam',
              price:
                  ((totalCampaignPrice ?? (totalPrice ?? 0 + 29.99)) + 29.99) -
                      (discount ?? 0))
        ],
      ),
    );
  }
}

class BasketTop extends StatefulWidget {
  const BasketTop(
      {super.key, required this.title, required this.totalItemCount});

  final String title;
  final int totalItemCount;

  @override
  State<BasketTop> createState() => _BasketTopState();
}

class _BasketTopState extends State<BasketTop> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: context.width(1),
      margin: const EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: SizedBox(
        width: context.width(0.7),
        child: ListTile(
          leading: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          title: Text(
            "(${widget.totalItemCount} ürün)",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          trailing: TextButton.icon(
              style: TextButton.styleFrom(
                iconColor: PColors.mainColor,
              ),
              onPressed: () async {
                changeLoading();
                await emptyBasket().then((value) {
                  if (value) {
                    pushToPage(context, const Home());
                  } else {
                    changeLoading();
                  }
                });
              },
              icon: const Icon(Icons.delete),
              label: const Text(
                "Ürünleri Sil",
                style: TextStyle(color: PColors.mainColor),
              )),
        ),
      ),
    );
  }
}
