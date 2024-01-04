import 'package:web_db/model/basket/get_basket_item_model.dart';

class OrderModel {
  String? date;
  String? orderId;
  double? totalPrice;
  double? campaignPrice;
  double? discountPrice;
  String? status;
  String? paymentMethod;
  String? transportMethod;
  List<GetBasketItemModel>? items;

  OrderModel(
      {this.date,
      this.orderId,
      this.totalPrice,
      this.campaignPrice,
      this.discountPrice,
      this.status,
      this.paymentMethod,
      this.transportMethod,
      this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderId = json['orderId'];
    totalPrice = json['totalPrice'];
    campaignPrice = json['campaignPrice'];
    discountPrice = json['discountPrice'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    transportMethod = json['transportMethod'];
    if (json['items'] != null) {
      final List<dynamic> list = json['items'] as List<dynamic>;
      items = list.map((v) {
        if (v != null) v as Map<String, dynamic>;
        return GetBasketItemModel.fromJson(v);
      }).toList();
    }
  }
}
