import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/compenent/home/app_bar.dart';
import 'package:cross_scroll/cross_scroll.dart';
import 'package:web_db/UI/compenent/home/con_decoration.dart';
import 'package:web_db/UI/compenent/home/list_category.dart';
import 'package:web_db/UI/compenent/home/row_colors_top.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<bool> enter = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int indexPage = 0;

  void nextPage() async {
    await pageController.nextPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }

  void prePage() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 10), curve: Curves.bounceInOut);
  }

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
            const AppBarCustom(),
            const TopRowsColors(),
            Container(
                color: PColors.categoryGrey,
                height: context.height(0.06),
                width: context.width(1),
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: categoryNames.length,
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => MouseRegion(
                    cursor: MaterialStateMouseCursor.clickable,
                    onEnter: (event) {
                      setState(() {
                        enter[index] = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        enter[index] = false;
                      });
                    },
                    child: SizedBox(
                      width: context.width(0.08),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: enter[index]
                                ? PColors.categoryButton
                                : PColors.categoryGrey,
                            shape: const RoundedRectangleBorder()),
                        onPressed: () {},
                        child: Text(
                          categoryNames[index],
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              wordSpacing: 0.45,
                              color: Colors.grey.shade800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )),
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
            SizedBox(
              width: context.width(1),
              height: context.height(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.width(0.8),
                    height: context.height(0.1),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        "Herkes bu ürünlerin peşinde",
                        style: GoogleFonts.roboto(
                            color: PColors.boldGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Şu an çok satılıyor",
                        style: GoogleFonts.roboto(
                            color: PColors.boldGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width(0.8),
                    height: context.height(0.4),
                    child: ListView.builder(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed("/page1", arguments: index),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: context.width(0.1),
                          height: context.height(0.4),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
                      child: Image.network(
                        imagesUrl[index],
                        height: context.height(0.48),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
        ButtonImage(
            pageController: pageController,
            onPressed: prePage,
            icon: Icons.arrow_left_rounded),
        SizedBox(
          height: context.height(0.07),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: imagesUrl.length,
            controller: scrollController,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: imagesUrl[index] == imagesUrl[indexPage]
                  ? const EdgeInsets.all(2)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: imagesUrl[index] == imagesUrl[indexPage]
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  imagesUrl[index],
                  color: Colors.transparent,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        ButtonImage(
            pageController: pageController,
            onPressed: nextPage,
            icon: Icons.arrow_right_rounded),
      ],
    );
  }
}

class ButtonImage extends StatelessWidget {
  const ButtonImage(
      {super.key,
      required this.pageController,
      required this.onPressed,
      required this.icon});

  final PageController pageController;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: context.width(0.035),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 1.5))),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

List<String> imagesUrl = [
  "https://picsum.photos/id/1/800/500",
  "https://picsum.photos/id/22/800/500",
  "https://picsum.photos/id/32/800/500",
  "https://picsum.photos/id/43/800/500",
  "https://picsum.photos/id/51/800/500",
  "https://picsum.photos/id/61/800/500",
  "https://picsum.photos/id/71/800/500",
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
