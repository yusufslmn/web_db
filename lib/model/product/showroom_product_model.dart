class ShowroomProduct {
  int? id;
  String? name;
  double? campaignPrice;
  double? price;
  double? rating;
  int? commentCount;
  List<dynamic>? pictures;

  ShowroomProduct(
      {this.id,
      this.name,
      this.price,
      this.campaignPrice,
      this.commentCount,
      this.pictures,
      this.rating});

  ShowroomProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentCount = json['commentCount'];
    rating = json['rating'];
    name = json['name'];
    campaignPrice = json['campaignPrice'];
    price = json['price'];
    pictures = json['pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['campaignPrice'] = campaignPrice;
    data['rating'] = rating;
    data['commentCount'] = commentCount;
    return data;
  }
}
