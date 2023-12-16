import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/product/add_to_basket.dart';
import 'package:web_db/UI/compenent/product/campaign.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/UI/compenent/product/image_container.dart';
import 'package:web_db/UI/compenent/product/love_and_compare.dart';
import 'package:web_db/UI/compenent/product/name.dart';
import 'package:web_db/UI/compenent/product/price.dart';
import 'package:web_db/UI/compenent/product/select_colors.dart';
import 'package:web_db/UI/compenent/product/seller_container.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';
import 'package:web_db/core/state/product_state.dart';
import '../compenent/product/comments.dart';
import '../compenent/product/product_property.dart';

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ProductState with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CrossScroll(
          verticalBar: const CrossScrollBar(),
          horizontalBar: const CrossScrollBar(),
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
                      const ImageContainer(),
                      Expanded(
                        child: Container(
                            color: PColors.productBackContainer,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomListTile(
                                    name: product.name,
                                    textStyle: CustomTextStyle.nameStyle),
                                CustomPriceText(
                                    product: product,
                                    commentRating: commentRating,
                                    commentTotal: commentTotal),
                                SellerContainer(seller: seller),
                                Text(
                                  "Renk",
                                  style: CustomTextStyle.sellerStyle,
                                ),
                                const SelectColor(),
                                AddToBasket(product: product),
                                const Spacer(),
                                const Divider(),
                                const LoveAndCompare()
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
          ),
        ),
      ),
    );
  }
}
