import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
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
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const TopAppBar(),
              Container(
                color: PColors.productBackContainer,
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
                          ?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "(${ref.read(basketProvider).basket.length} ürün)",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.bold),
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                tileColor: PColors.productBackContainer,
                                leading: TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: PColors.mainColor,
                                    ),
                                    label: const Text(
                                      "Kupon Ekle",
                                      style:
                                          TextStyle(color: PColors.mainColor),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: context.height(0.8),
                              child: ListView.builder(
                                itemCount:
                                    ref.read(basketProvider).basket.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      color: PColors.productBackContainer,
                                      height: context.height(0.25),
                                      child: Column(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: ListTile(
                                              leading: Text("Satıcı:"),
                                              title: Text("Hepsibunda"),
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.white,
                                          ),
                                          const Expanded(
                                            flex: 2,
                                            child: ListTile(
                                              leading: Icon(
                                                  Icons.directions_bus_outlined,
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
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Image.network(
                                                          productImages[index]),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                              "${ref.read(basketProvider).basket[index].name}"),
                                                          subtitle: Text(ref
                                                              .read(
                                                                  productProvider)
                                                              .color),
                                                        ),
                                                        ListTile(
                                                          leading: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        if (total ==
                                                                            1) {
                                                                          ref
                                                                              .read(basketProvider)
                                                                              .basket
                                                                              .removeAt(index);
                                                                        } else {
                                                                          total--;
                                                                        }
                                                                      });
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete_outline_outlined,
                                                                      color: PColors
                                                                          .mainColor,
                                                                    )),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Text(
                                                                    "$total",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        total++;
                                                                      });
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color: PColors
                                                                          .mainColor,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          trailing: Text(
                                                            "${ref.read(basketProvider).basket[index].price} TL",
                                                            style: const TextStyle(
                                                                fontSize: 15,
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
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: context.height(0.5),
                          padding: EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: PColors.productBackContainer,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SEPETTEKİ ÜRÜNLER (${ref.read(basketProvider).basket.length})",
                                style: const TextStyle(
                                    color: PColors.mainColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "${ref.read(basketProvider).toplam()} TL",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Spacer(
                                flex: 8,
                              ),
                              SizedBox(
                                height: context.height(0.06),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: PColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {},
                                  child: Text(
                                    "   Alışverişi tamamla   ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.height(0.0150),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              CustomListTileText(
                                price: ref.read(basketProvider).toplam(),
                                title: "Ürünler:",
                              ),
                              CustomListTileText(
                                price: 29.99,
                                title: "Kargo:",
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
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
