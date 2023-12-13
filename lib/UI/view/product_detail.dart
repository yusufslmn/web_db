import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/button_image.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/product/campaign.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/UI/compenent/product/product_rating.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';
import 'package:web_db/core/state/product_state.dart';

import '../compenent/product/comments.dart';
import '../compenent/product/product_property.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ProductState with TickerProviderStateMixin {
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
                margin: EdgeInsets.symmetric(
                    vertical: 20, horizontal: context.width(0.15)),
                width: context.width(0.7),
                height: context.height(0.8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    SizedBox(
                      width: context.width(0.35),
                      height: context.height(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 8, child: imageBuilder(context)),
                          Expanded(flex: 2, child: rowIndicator(context)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          color: PColors.productBackContainer,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  title: Text(product.name ?? "Error"),
                                  titleTextStyle: CustomTextStyle.nameStyle),
                              ListTile(
                                title: Text("${product.price ?? 00.00},00 TL"),
                                titleTextStyle: CustomTextStyle.priceStyle,
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RatingProduct(
                                      commentRating: commentRating,
                                    ),
                                    Text("$commentTotal değerlendirme",
                                        style: CustomTextStyle.commentStyle)
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: context.width(0.15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: ListTile(
                                  tileColor: Colors.pink,
                                  selectedTileColor: Colors.pink,
                                  selectedColor: Colors.pink,
                                  selected: true,
                                  enabled: true,
                                  leading: Text(
                                    "Satıcı:",
                                    style: CustomTextStyle.sellerStyle,
                                  ),
                                  title: Text(
                                    seller,
                                    style: CustomTextStyle.sellerStyleBlue,
                                  ),
                                ),
                              ),
                              Text(
                                "Renk",
                                style: CustomTextStyle.sellerStyle,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      color,
                                      style: CustomTextStyle.sellerStyle,
                                    ),
                                    SizedBox(
                                      width: context.width(0.3),
                                      height: context.height(0.1),
                                      child: ListView.builder(
                                        itemCount: colors.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            setState(() {
                                              color =
                                                  ColorsName.values[index].name;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(16.0),
                                            width: context.width(0.08),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: ColorsName
                                                                .values[index]
                                                                .name !=
                                                            color
                                                        ? Colors.grey.shade400
                                                        : PColors.mainColor)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                      productImages[0]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    ColorsName
                                                        .values[index].name,
                                                    style: TextStyle(
                                                        fontSize: context
                                                            .width(0.009)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: context.width(0.06),
                                        height: context.height(0.05),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      Positioned(
                                          left: 0,
                                          child: SizedBox(
                                            width: context.width(0.0185),
                                            child: IconButton(
                                                style: IconButton.styleFrom(
                                                    elevation: 0.0,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        4)))),
                                                onPressed: () {
                                                  setState(() {
                                                    if (total > 1) total--;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.horizontal_rule_rounded,
                                                  size: context.width(0.01),
                                                )),
                                          )),
                                      Positioned(
                                          right: 0,
                                          child: SizedBox(
                                            width: context.width(0.0185),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    total++;
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    elevation: 0.0,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        4),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        4)))),
                                                icon: Icon(
                                                  Icons.add,
                                                  size: context.width(0.01),
                                                )),
                                          )),
                                      Positioned(
                                        left: context.width(0.0185),
                                        top: context.height(0.0025),
                                        child: Container(
                                          color: Colors.white,
                                          width: context.width(0.023),
                                          height: context.height(0.045),
                                          alignment: Alignment.center,
                                          child: Text("$total\nAdet",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: context.width(0.1),
                                    height: context.height(0.05),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            alignment: Alignment.center,
                                            backgroundColor: PColors.mainColor),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.add_shopping_cart_rounded,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Sepete Ekle",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Divider(),
                              Row(
                                children: [
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.favorite_border_outlined),
                                      label: const Text("Beğen")),
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.compare_arrows_outlined),
                                      label: const Text("Karşılaştır")),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                )),
            Container(
              width: context.width(0.4),
              margin: EdgeInsets.symmetric(
                  vertical: 20, horizontal: context.width(0.15)),
              child: TabBar(
                  onTap: (value) {
                    bottomTabController.animateToPage(value,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  },
                  controller: TabController(vsync: this, length: 3),
                  tabs: const [
                    Text("Yorumlar"),
                    Text("Ürün Açıklaması"),
                    Text("Kampanyalar"),
                  ]),
            ),
            Container(
              width: context.width(0.7),
              margin: EdgeInsets.symmetric(
                  vertical: 20, horizontal: context.width(0.15)),
              height: context.height(1),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: bottomTabController,
                children: const [
                  Comments(),
                  ProductProperty(),
                  Campaign(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Stack imageBuilder(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.height(0.6),
          width: context.width(0.35),
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productDetailImages.length,
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  if (value < productDetailImages.length) {
                    indexPage = value;
                  }
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    productDetailImages[index],
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
                );
              }),
        ),
        Positioned(
            left: 0,
            top: context.height(0.3),
            child: ButtonImage(
                onPressed: preImage, icon: Icons.arrow_left_rounded)),
        Positioned(
            right: 0,
            top: context.height(0.3),
            child: ButtonImage(
                onPressed: nextImage, icon: Icons.arrow_right_rounded)),
      ],
    );
  }

  Padding rowIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productDetailImages.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => pageController.jumpToPage(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding:
                  productDetailImages[index] == productDetailImages[indexPage]
                      ? const EdgeInsets.all(2)
                      : EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: productDetailImages[index] ==
                          productDetailImages[indexPage]
                      ? PColors.mainColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  productDetailImages[index],
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
      ),
    );
  }
}
