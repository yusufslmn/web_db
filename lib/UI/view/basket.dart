// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/basket/basket_custom_listtile.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/basket/add_basket_modal.dart';
import 'package:web_db/core/model/basket/basket_model.dart';
import 'package:web_db/core/service/basket/add_basket_service.dart';
import 'package:web_db/core/service/basket/empty_basket_service.dart';
import 'package:web_db/core/service/basket/get_basket_service.dart';
import 'package:web_db/core/settings/route_settings.dart';
import 'package:web_db/core/state/basket_state.dart';
import 'package:web_db/core/state/product_state.dart';

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
                                    AddToCoupon(),
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
                                                          Icons
                                                              .directions_bus_outlined,
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
                                                                  title: Text(snapshot
                                                                          .data!
                                                                          .items![
                                                                              index]
                                                                          .productName ??
                                                                      ""),
                                                                  subtitle: Text(ref
                                                                      .read(
                                                                          productProvider)
                                                                      .color),
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
                                                                              AddBasketModel addToBasketItem = AddBasketModel(productId: snapshot.data?.items?[index].productId ?? 0, quantity: (snapshot.data?.items?[index].quantity ?? 0) - 1);
                                                                              await addToBasket(addToBasketItem);
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
                                                                              AddBasketModel addToBasketItem = AddBasketModel(productId: snapshot.data?.items?[index].productId ?? 0, quantity: (snapshot.data!.items![index].quantity ?? 0) + 1);
                                                                              await addToBasket(addToBasketItem);
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
                                                                        "${snapshot.data?.items?[index].price ?? 0} TL",
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
                                                                                "${snapshot.data?.items?[index].campaignPrice ?? 0} TL",
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

class AddToCoupon extends StatelessWidget {
  AddToCoupon({
    super.key,
  });
  final int couponPrice = 200;
  final String? couponCode = "HPS200";
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          controller: _expansionTileController,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: PColors.productBackContainer)),
          leading: TextButton.icon(
              onPressed: () {
                if (!_expansionTileController.isExpanded)
                  _expansionTileController.expand();
                else {
                  _expansionTileController.collapse();
                }
              },
              icon: const Icon(
                Icons.add_circle_outline_outlined,
                color: PColors.mainColor,
              ),
              label: const Text(
                "Kupon Ekle",
                style: TextStyle(color: PColors.mainColor),
              )),
          title: const SizedBox.shrink(),
          children: [
            Container(
                height: context.height(0.2),
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SizedBox(
                    width: context.width(0.1),
                    height: context.height(0.2),
                    child: Card(
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: PColors.mainColor,
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.all(4.0),
                            child: Text(
                              "$couponCode",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: PColors.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Her üründe geçerli $couponPrice TL",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: PColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                onPressed: () {},
                                child: Text(
                                  "Kuponu Kullan",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ]),
    );
  }
}

class BasketTotalContainer extends ConsumerWidget {
  const BasketTotalContainer({
    super.key,
    required this.totalCampaignPrice,
    required this.totalItemCount,
    required this.totalPrice,
  });
  final double? totalCampaignPrice;
  final int? totalItemCount;
  final double? totalPrice;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Text("${totalPrice ?? 0} TL",
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
                        "$totalCampaignPrice TL",
                        style: const TextStyle(
                            color: Colors.red,
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
              onPressed: () {},
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
          )
        ],
      ),
    );
  }
}

class BasketTop extends ConsumerWidget {
  const BasketTop(
      {super.key, required this.title, required this.totalItemCount});

  final String title;
  final int totalItemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      width: context.width(1),
      margin: const EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      child: SizedBox(
        width: context.width(0.7),
        child: ListTile(
          leading: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          title: Text(
            "($totalItemCount ürün)",
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
                await emptyBasket().then((value) {
                  if (value) pushToPage(context, const Home());
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
