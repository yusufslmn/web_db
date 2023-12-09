import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/button_image.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';
import 'package:web_db/core/state/product_state.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/product_detail';
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ProductState {
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
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(product.name ?? "Error"),
                                titleTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ListTile(
                                title: Text("${product.price ?? 00.00},00 TL"),
                                titleTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RatingProduct(
                                      commentRating: commentRating,
                                    ),
                                    Text(
                                      "$commentTotal değerlendirme",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: context.width(0.15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
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
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  title: Text(
                                    "$seller",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
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

class RatingProduct extends StatelessWidget {
  const RatingProduct({
    super.key,
    required this.commentRating,
  });
  final double commentRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "4.7",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_outlined,
          color: PColors.mainColor,
        ),
        Icon(
          Icons.star_half_outlined,
          color: PColors.mainColor,
        ),
      ],
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments(this.product);
}
