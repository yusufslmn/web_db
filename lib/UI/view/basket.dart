import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/add_basket_modal.dart';
import 'package:web_db/core/model/basket_model.dart';
import 'package:web_db/core/service/basket/add_basket_service.dart';
import 'package:web_db/core/service/basket/get_basket_service.dart';
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
          children: [
            const TopAppBar(),
            BasketTop(
              title: title,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.width(0.15)),
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
                          const AddToCoupon(),
                          SizedBox(
                            height: context.height(0.8),
                            child: FutureBuilder<BasketModal>(
                              future: fetchBasketItem(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.items?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          color: Colors.white,
                                          height: context.height(0.25),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: ListTile(
                                                  leading: Text("Satıcı:"),
                                                  title: Text(
                                                      "${snapshot.data!.items?[index].brandName}"),
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
                                                  titleTextStyle:
                                                      TextStyle(fontSize: 15),
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
                                                                  .all(16.0),
                                                          child: Image.network(
                                                              snapshot
                                                                  .data!
                                                                  .items?[index]
                                                                  .pictures!
                                                                  .first),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                  "${snapshot.data!.items?[index].productName}"),
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
                                                                        color: Colors
                                                                            .white)),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          changeLoading();
                                                                          AddBasketModel
                                                                              addToBasketItem =
                                                                              AddBasketModel(productId: snapshot.data!.items?[index].productId, quantity: 1);
                                                                          await addToBasket(addToBasketItem).whenComplete(() =>
                                                                              fetchBasketItem());
                                                                          changeLoading();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .delete_outline_outlined,
                                                                          color:
                                                                              PColors.mainColor,
                                                                        )),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data!.items?[index].quantity}",
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          changeLoading();
                                                                          AddBasketModel
                                                                              addToBasketItem =
                                                                              AddBasketModel(productId: snapshot.data!.items?[index].productId, quantity: 1);
                                                                          await addToBasket(addToBasketItem).whenComplete(() =>
                                                                              fetchBasketItem());
                                                                          changeLoading();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              PColors.mainColor,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              trailing: Text(
                                                                "${snapshot.data!.items?[index].price} TL",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: BasketTotalContainer(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class AddToCoupon extends StatelessWidget {
  const AddToCoupon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: PColors.productBackContainer)),
          leading: TextButton.icon(
              onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: PColors.productBackContainer)),
                  labelText: "Kupon Kodu",
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_box_sharp)),
                ),
              ),
            )
          ]),
    );
  }
}

class BasketTotalContainer extends ConsumerWidget {
  const BasketTotalContainer({
    super.key,
  });
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
          const Text(
            "SEPETTEKİ ÜRÜNLER (0)",
            style: TextStyle(
                color: PColors.mainColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
          const Text(
            "0 TL",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
          const CustomListTileText(
            price: 0,
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
  const BasketTop({
    super.key,
    required this.title,
  });

  final String title;

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
            "(0  ürün)",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          trailing: TextButton.icon(
              style: TextButton.styleFrom(
                iconColor: PColors.mainColor,
              ),
              onPressed: () {},
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

class CustomListTileText extends StatelessWidget {
  const CustomListTileText({
    super.key,
    required this.title,
    required this.price,
  });
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 12,
            color: PColors.titleGrey,
            fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        "$price TL",
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
