import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/view/basket.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/settings/route_settings.dart';
import 'package:web_db/core/state/basket_state.dart';

class Buying extends ConsumerStatefulWidget {
  const Buying({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuyingState();
}

class _BuyingState extends ConsumerState<Buying> {
  bool isSelectKargo1 = true;
  bool isSelectKargo2 = false;
  bool isSelectedPay1 = true;
  bool isSelectedPay2 = true;
  bool isSelectedPay3 = true;
  bool isSelectedPay4 = true;
  bool isSelectedPay5 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buyingAppBar(context),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Teslimat Adresim",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isSelectKargo2 = false;
                                  isSelectKargo1 = !isSelectKargo1;
                                });
                              },
                              leading: isSelectKargo1
                                  ? Icon(
                                      Icons.adjust_outlined,
                                      color: PColors.mainColor,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: PColors.mainColor,
                                    ),
                              title: Text(
                                "Adresime Gönder",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isSelectKargo1 = false;
                                  isSelectKargo2 = !isSelectKargo2;
                                });
                              },
                              leading: isSelectKargo2
                                  ? Icon(
                                      Icons.adjust_outlined,
                                      color: PColors.mainColor,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: PColors.mainColor,
                                    ),
                              title: Text(
                                "Teslimat Noktasına Gönder",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Ödeme Seçenekleri",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  isSelectKargo2 = false;
                                  isSelectedPay1 = !isSelectedPay1;
                                });
                              },
                              leading: isSelectedPay1
                                  ? Icon(
                                      Icons.adjust_outlined,
                                      color: PColors.mainColor,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: PColors.mainColor,
                                    ),
                              title: Text(
                                "Kapıda Ödeme",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(flex: 2, child: BuyingTotalContainer())
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
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "hepsibunda",
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
          icon: Icon(
            Icons.security,
            color: Colors.green,
          ),
          label: Text(
            "Güvenli Alışveriş",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CircleAvatar(
            radius: context.height(0.025),
            child: Text("YS"),
            backgroundColor: Colors.grey.shade300,
          ),
        )
      ],
    );
  }
}

class BuyingTotalContainer extends ConsumerWidget {
  const BuyingTotalContainer({
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
          Text(
            "SEPETTEKİ ÜRÜNLER (${ref.read(basketProvider).basket.length})",
            style: const TextStyle(
                color: PColors.mainColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "${ref.read(basketProvider).toplam()} TL",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
            price: ref.read(basketProvider).toplam(),
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
