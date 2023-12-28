class GetBasketItemModel {
  int? productId;
  int? quantity;
  double? price;
  double? campaignPrice;
  String? productName;
  String? brandName;
  List<dynamic>? pictures;

  GetBasketItemModel(
      {this.productId,
      this.quantity,
      this.price,
      this.brandName,
      this.productName,
      this.campaignPrice,
      this.pictures});

  GetBasketItemModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    price = json['price'];
    productName = json['productName'];
    brandName = json['brandName'];
    campaignPrice = json['campaignPrice'];
    pictures = json['pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['brandName'] = brandName;
    data['productName'] = productName;
    data['campaignPrice'] = campaignPrice;
    data['pictures'] = pictures;
    return data;
  }
}
