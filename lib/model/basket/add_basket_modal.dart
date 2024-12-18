// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddBasketModel {
  int? productId;
  int? quantity;
  List<int?>? attributeItemIds;

  AddBasketModel({this.productId, this.quantity, this.attributeItemIds});

  AddBasketModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['attributeItemIds'] = attributeItemIds;
    return data;
  }
}
