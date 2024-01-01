// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/product_comment_model.dart';
import 'package:web_db/core/service/comment/add_commen_to_comment.dart';
import 'package:web_db/core/service/comment/get_comment.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required this.productId});
  final int productId;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  double rating = 0.0;
  bool orderByDate = false;
  final ScrollController controller = ScrollController();
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> sendCommentRating(int commentId, double rating) async {
    changeLoading();
    await postCommentRating(commentId, rating);
    changeLoading();
  }

  @override
  void initState() {
    fetchProductComment(widget.productId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductCommentModel>>(
      future: fetchProductComment(widget.productId, orderByDate),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: context.width(0.5),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: PColors.productBackContainer)),
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: PColors.productBackContainer)),
                  controller: _expansionTileController,
                  tilePadding: EdgeInsets.zero,
                  title: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Flitreleme"),
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color:
                                              PColors.productBackContainer))),
                              onPressed: () {
                                setState(() {
                                  orderByDate = true;
                                });
                              },
                              child: const Text(
                                "En Yeni",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color:
                                              PColors.productBackContainer))),
                              onPressed: () {
                                setState(() {
                                  orderByDate = false;
                                });
                              },
                              child: const Text(
                                "En Faydalı",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Scrollbar(
                controller: controller,
                child: SizedBox(
                  height: context.height(1.3),
                  child: ListView.builder(
                    controller: controller,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              await sendCommentRating(
                                                  snapshot.data![index].id ?? 0,
                                                  rating);
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Gönder")),
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Vazgeç")),
                                  ],
                                )
                              ],
                              title: Column(
                                children: [
                                  const Text("Yoruma yıldız ver"),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating1) {
                                      setState(() {
                                        rating = rating1;
                                        print(rating);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: PColors.productBackContainer,
                                  radius: context.height(0.03),
                                  child: Text(
                                    "${snapshot.data![index].nameSurname!.split(' ').first.characters.first}${snapshot.data![index].nameSurname!.split(' ')[1].characters.first}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )),
                            Expanded(
                              flex: 6,
                              child: Card(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: RatingBarIndicator(
                                              rating: snapshot
                                                      .data![index].rating ??
                                                  0,
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemSize: 20,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Text(
                                                "${snapshot.data![index].date} |",
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade400)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Text(
                                                "${snapshot.data![index].nameSurname}",
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade400)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: context.width(0.3),
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                            snapshot.data![index].comment ??
                                                "error"),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "${snapshot.data![index].otherUsersRating?.toStringAsFixed(2) ?? 0}"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: RatingBarIndicator(
                                                rating: snapshot.data![index]
                                                        .otherUsersRating ??
                                                    0,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 5,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Text(
                                                  "${snapshot.data![index].otherUsersRatingCount}"),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const Expanded(flex: 3, child: SizedBox())
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
