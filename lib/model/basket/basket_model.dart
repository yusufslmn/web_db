import 'package:web_db/model/basket/get_basket_item_model.dart';

class BasketModal {
  List<GetBasketItemModel>? items;
  int? totalItemCount;
  double? totalPrice;
  double? totalCampaignPrice;

  BasketModal(
      {this.items,
      this.totalItemCount,
      this.totalPrice,
      this.totalCampaignPrice});

  BasketModal.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      final List<dynamic> list = json['items'] as List<dynamic>;
      items = list.map((v) {
        if (v != null) v as Map<String, dynamic>;
        return GetBasketItemModel.fromJson(v);
      }).toList();
    }
    totalItemCount = json['totalItemCount'];
    totalPrice = json['totalPrice'];
    totalCampaignPrice = json['totalCampaignPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalItemCount'] = totalItemCount;
    data['totalPrice'] = totalPrice;
    data['totalCampaignPrice'] = totalCampaignPrice;
    return data;
  }
}
