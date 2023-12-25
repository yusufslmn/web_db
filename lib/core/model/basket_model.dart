import 'package:web_db/core/model/get_basket_model.dart';

class BasketModal {
  List<GetBasketItemModel>? items;
  int? totalItemCount;
  int? totalPrice;
  double? totalCampaignPrice;

  BasketModal(
      {this.items,
      this.totalItemCount,
      this.totalPrice,
      this.totalCampaignPrice});

  BasketModal.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <GetBasketItemModel>[];
      if (json['items'] is List) {
        json['items'].map((v) {
          Map<String, dynamic> mapData = {};
          mapData = v;
          items!.add(GetBasketItemModel.fromJson(mapData));
        });
      }
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
