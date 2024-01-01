import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:web_db/UI/view/login.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/product_comment_model.dart';
import 'package:web_db/core/service/comment/add_commen_to_comment.dart';
import 'package:web_db/core/service/comment/get_comment.dart';
import 'package:web_db/core/settings/route_settings.dart';

class SellerPanel extends StatefulWidget {
  const SellerPanel({super.key});

  @override
  State<SellerPanel> createState() => _SellerPanelState();
}

class _SellerPanelState extends State<SellerPanel> {
  ScrollController controller = ScrollController();
  bool isLoading = false;

  double? rating;

  bool orderByDate = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => pushReplacement(context, const Login()),
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text(
          "Satıcı Paneli",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<ProductCommentModel>>(
            future: fetchProductComment(1, true),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scrollbar(
                  controller: controller,
                  child: SizedBox(
                    height: context.height(1),
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
                                                    snapshot.data![index].id ??
                                                        0,
                                                    rating!);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Gönder")),
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Vazgeç")),
                                    ],
                                  )
                                ],
                                title: Column(
                                  children: [
                                    const Text("Yoruma yanıt ver"),
                                    TextFormField(
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey))),
                                    )
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
                                    backgroundColor:
                                        PColors.productBackContainer,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Text(
                                                  "${snapshot.data![index].date} |",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey.shade400)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Text(
                                                  "${snapshot.data![index].nameSurname}",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey.shade400)),
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
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
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
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
