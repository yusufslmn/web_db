class PostCommentModel {
  int? productId;
  double? rating;
  String? comment;

  PostCommentModel({this.productId, this.rating, this.comment});

  PostCommentModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    rating = json['rating'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['rating'] = rating;
    data['comment'] = comment;
    return data;
  }
}
