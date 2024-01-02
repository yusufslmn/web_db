import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/appBar/top_app_bar.dart';
import 'package:cross_scroll/cross_scroll.dart';
import 'package:web_db/UI/compenent/home/button_image.dart';
import 'package:web_db/UI/compenent/home/con_decoration.dart';
import 'package:web_db/UI/compenent/home/top_seller.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/state/home_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends StateHome {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CrossScroll(
      verticalBar: const CrossScrollBar(),
      horizontalBar: const CrossScrollBar(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopAppBar(),
            Container(
              decoration: decorationContainer(),
              width: context.width(1),
              height: context.height(0.7),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageBuilder(context),
                  rowIndicator(context),
                ],
              ),
            ),
            TopSellerProducts(
              topSellerController: topSellerController,
            ),
          ],
        ),
      ),
    ));
  }

  SizedBox imageBuilder(BuildContext context) {
    return SizedBox(
      width: context.width(0.6),
      height: context.height(0.5),
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imagesUrl.length,
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              if (value < imagesUrl.length) {
                indexPage = value;
              }
            });
          },
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: context.width(0.6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textImages1[index],
                            style: GoogleFonts.roboto(
                                color: PColors.boldGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            textImages2[index],
                            style: GoogleFonts.roboto(
                                color: PColors.boldGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 60),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                    backgroundColor: PColors.categoryButton),
                                onPressed: () {},
                                child: const Text("Acele et kaçırma")),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        imagesUrl[index],
                        height: context.height(0.48),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Row rowIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonImage(onPressed: prePage, icon: Icons.arrow_left_rounded),
        SizedBox(
          height: context.height(0.07),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: imagesUrl.length,
            controller: scrollController,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => pageController.jumpToPage(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                padding: imagesUrl[index] == imagesUrl[indexPage]
                    ? const EdgeInsets.all(2)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: imagesUrl[index] == imagesUrl[indexPage]
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagesUrl[index],
                    color: Colors.transparent,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        ButtonImage(onPressed: nextPage, icon: Icons.arrow_right_rounded),
      ],
    );
  }
}

List<String> imagesUrl = [
  "images/1.jpg",
  "images/2.jpg",
  "images/3.jpg",
  "images/4.jpg",
  "images/5.jpg",
  "images/6.jpg",
  "images/7.jpg",
];

List<String> textImages1 = [
  "Süper Ürünlerde",
  "Süper Ürünlerde",
  "Süper Ürünlerde",
  "Süper Ürünlerde",
  "Süper Ürünlerde",
  "Süper Ürünlerde",
  "Süper Ürünlerde",
];

List<String> textImages2 = [
  "Süper İndirimler",
  "Süper İndirimler",
  "Süper İndirimler",
  "Süper İndirimler",
  "Süper İndirimler",
  "Süper İndirimler",
  "Süper İndirimler",
];
