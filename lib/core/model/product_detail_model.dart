class ProductDetailModel {
  int? id;
  double? campaignPrice;
  double? price;
  String? name;
  double? rating;
  int? commentCount;
  List<dynamic>? pictures;
  String? description;
  String? brandName;

  ProductDetailModel(
      {this.id,
      this.campaignPrice,
      this.price,
      this.name,
      this.rating,
      this.commentCount,
      this.brandName,
      this.pictures,
      this.description});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignPrice = json['campaignPrice'];
    price = json['price'];
    name = json['name'];
    brandName = json['brandName'];
    rating = json['rating'];
    commentCount = json['commentCount'];
    pictures = json['pictures'].cast<String>();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['campaignPrice'] = campaignPrice;
    data['price'] = price;
    data['name'] = name;
    data['brandName'] = brandName;
    data['rating'] = rating;
    data['commentCount'] = commentCount;
    data['pictures'] = pictures;
    data['description'] = description;
    return data;
  }
}
