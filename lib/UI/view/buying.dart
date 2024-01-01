// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/basket/basket_custom_listtile.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/UI/view/profile.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/buying/create_order_model.dart';
import 'package:web_db/core/model/buying/get_payment_model.dart';
import 'package:web_db/core/model/buying/get_transport_model.dart';
import 'package:web_db/core/service/buying/create_order_service.dart';
import 'package:web_db/core/service/buying/get_payment_service.dart';
import 'package:web_db/core/service/buying/get_transport_service.dart';
import 'package:web_db/core/settings/route_settings.dart';

class Buying extends ConsumerStatefulWidget {
  const Buying(
      {super.key,
      required this.totalPrice,
      required this.totalItemCount,
      required this.totalCampaignPrice,
      required this.couponCode,
      required this.discount});
  final double? totalPrice;
  final double? totalCampaignPrice;
  final int? totalItemCount;
  final String? couponCode;
  final double? discount;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyingState();
}

class _BuyingState extends ConsumerState<Buying> {
  bool isLoading = false;
  int transportId = 1;
  int paymentId = 1;
  List<GetTransportModel>? transportList;
  List<GetPaymentModel>? paymentList;

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getData() async {
    _changeLoading();
    transportList = await fetchTransportItem();
    paymentList = await fetchPaymentItem();
    _changeLoading();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buyingAppBar(context),
      backgroundColor: PColors.productBackContainer,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.width(0.15)),
        width: context.width(0.7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                  flex: 8,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              const TextTitle(title: "Teslimat Seçenekleri"),
                              DropdownMenu(
                                  initialSelection: transportId,
                                  enableSearch: false,
                                  enableFilter: false,
                                  onSelected: (value) {
                                    setState(() {
                                      transportId = value as int;
                                      print(transportId);
                                    });
                                  },
                                  dropdownMenuEntries: transportList
                                          ?.map((e) => DropdownMenuEntry(
                                              value: e.id,
                                              label: e.name ?? ' '))
                                          .toList() ??
                                      []),
                              const TextTitle(
                                title: "Ödeme Seçenekleri",
                              ),
                              DropdownMenu(
                                  initialSelection: paymentId,
                                  enableSearch: false,
                                  enableFilter: false,
                                  onSelected: (value) {
                                    setState(() {
                                      paymentId = value as int;
                                      print(paymentId);
                                    });
                                  },
                                  dropdownMenuEntries: paymentList
                                          ?.map((e) => DropdownMenuEntry(
                                              value: e.id,
                                              label: e.name ?? ' '))
                                          .toList() ??
                                      []),
                            ])),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: context.height(0.5),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SEPETTEKİ ÜRÜNLER (${widget.totalItemCount ?? 0})",
                          style: const TextStyle(
                              color: PColors.mainColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          "${(widget.totalCampaignPrice ?? (widget.totalPrice ?? 0)).toStringAsFixed(2)}TL",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                            onPressed: () async {
                              _changeLoading();
                              CreateOrderModel createOrderModel =
                                  CreateOrderModel(
                                      couponCode: widget.couponCode,
                                      paymentMethodId: paymentId,
                                      transportMethodId: transportId);
                              await fetchCreateOrder(createOrderModel)
                                  .then((value) {
                                if (value) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: const Text("Siparişiniz alındı"),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () =>
                                                    pushReplacement(
                                                        context, const Home()),
                                                child: const Text(
                                                    "Alışverişe Devam Et")),
                                          )
                                        ]),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: const Text(
                                            "Siparişiniz oluşturalamadı tekrar deneyiniz"),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child:
                                                    const Text("Tekrar Dene")),
                                          )
                                        ]),
                                  );
                                }
                              });
                              _changeLoading();
                            },
                            child: Text(
                              "Siparişi Onayla",
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
                          price: (widget.totalCampaignPrice ??
                                  (widget.totalPrice ?? 0 + 29.99)) +
                              29.99,
                          title: "Ürünler:",
                        ),
                        const CustomListTileText(
                          price: 29.99,
                          title: "Kargo:",
                        ),
                        const Divider(),
                        CustomListTileText(
                            title: 'Toplam',
                            price: ((widget.totalCampaignPrice ??
                                        (widget.totalPrice ?? 0 + 29.99)) +
                                    29.99) -
                                (widget.discount ?? 0))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }

  AppBar buyingAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: context.width(0.4),
      toolbarHeight: context.height(0.1),
      leading: GestureDetector(
        onTap: () => pushToPage(context, const Home()),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "hepsionda",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              color: PColors.mainColor,
              fontSize: context.height(0.025),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.security,
            color: Colors.green,
          ),
          label: const Text(
            "Güvenli Alışveriş",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkResponse(
            onTap: () => pushToPage(context, const Profile()),
            child: CircleAvatar(
              radius: context.height(0.025),
              backgroundColor: Colors.grey.shade300,
              child: const Text("YS"),
            ),
          ),
        )
      ],
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
