class ProductCommentModel {
  int? id;
  String? comment;
  double? rating;
  double? otherUsersRatingCount;
  double? otherUsersRating;
  String? date;
  String? nameSurname;

  ProductCommentModel(
      {this.id,
      this.comment,
      this.rating,
      this.date,
      this.nameSurname,
      this.otherUsersRatingCount,
      this.otherUsersRating});

  ProductCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    nameSurname = json['nameSurname'];
    date = json['date'];
    otherUsersRatingCount = json['otherUsersRatingCount'];
    otherUsersRating = json['otherUsersRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    data['nameSurname'] = nameSurname;
    data['date'] = date;
    data['otherUsersRatingCount'] = otherUsersRatingCount;
    data['otherUsersRating'] = otherUsersRating;
    return data;
  }
}
