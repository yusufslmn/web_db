import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product/product_comment_model.dart';
import 'package:web_db/core/service/product/get_comment.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required this.productId});
  final int productId;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final double rating = 0.0;
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    fetchProductComment(widget.productId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductCommentModel>>(
      future: fetchProductComment(widget.productId, true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scrollbar(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: RatingBar.builder(
                                      initialRating:
                                          snapshot.data![index].rating ?? 0,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 5,
                                      ),
                                      onRatingUpdate: (double value) {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Text(
                                        "${snapshot.data![index].date} |",
                                        style: TextStyle(
                                            color: Colors.grey.shade400)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Text(
                                        "${snapshot.data![index].nameSurname}",
                                        style: TextStyle(
                                            color: Colors.grey.shade400)),
                                  ),
                                ],
                              ),
                              Container(
                                width: context.width(0.3),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                    snapshot.data![index].comment ?? "error"),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: RatingBar.builder(
                                        initialRating: snapshot.data![index]
                                                .otherUsersRating ??
                                            0,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 5,
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
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
