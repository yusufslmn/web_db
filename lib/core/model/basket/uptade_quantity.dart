// ignore_for_file: public_member_api_docs, sort_constructors_first
class UptadeQuantity {
  int? productId;
  int? quantity;

  UptadeQuantity({this.productId, this.quantity});

  UptadeQuantity.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
