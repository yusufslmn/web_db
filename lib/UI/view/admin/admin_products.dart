import 'package:desktop_scrollbar/desktop_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/home/rating.dart';
import 'package:web_db/UI/compenent/home/top_seller.dart';
import 'package:web_db/UI/view/admin/admin_product_comment.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/showroom_product_model.dart';
import 'package:web_db/core/service/category/get_category_product.dart';
import 'package:web_db/core/settings/route_settings.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({super.key, required this.id, required this.name});
  final int id;
  final String name;
  @override
  State<AdminProducts> createState() => _CategoryState();
}

class _CategoryState extends State<AdminProducts> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                widget.name,
                style: const TextStyle(
                    color: PColors.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<ShowroomProduct>>(
              future: fetchCategoryProduct(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: snapshot.data!.length * context.height(0.4),
                      child: DesktopScrollbar(
                          controller: _scrollController,
                          thumbColor: Colors.black,
                          radius: const Radius.circular(8),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, childAspectRatio: 0.6),
                            controller: _scrollController,
                            itemCount: snapshot.data!.length,
                            cacheExtent: 500,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                pushToPage(
                                    context,
                                    AdminProductComment(
                                      productId: snapshot.data![index].id ?? 0,
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: context.width(0.12),
                                height: context.height(0.5),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Image.network(
                                        snapshot.data![index].pictures!.first,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return Placeholder();
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: PaddingCustom.symetric,
                                        alignment: Alignment.center,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          snapshot.data![index].name ?? "error",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Rating(
                                          rating:
                                              snapshot.data![index].rating ??
                                                  0.0,
                                          totalComment: snapshot
                                                  .data![index].commentCount ??
                                              0),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: PaddingCustom.symetric,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                "${snapshot.data![index].price ?? 0} TL",
                                                style: TextStyle(
                                                  decoration: snapshot
                                                              .data![index]
                                                              .campaignPrice ==
                                                          null
                                                      ? null
                                                      : TextDecoration
                                                          .lineThrough,
                                                  decorationThickness: snapshot
                                                              .data![index]
                                                              .campaignPrice ==
                                                          null
                                                      ? null
                                                      : 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            snapshot.data![index]
                                                        .campaignPrice ==
                                                    null
                                                ? const SizedBox.shrink()
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      "${snapshot.data![index].campaignPrice ?? 0} TL",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      )),
    );
  }
}
