class CouponModel {
  String? code;
  double? discount;
  int? remainedQuantity;
  bool? isAvailable;

  CouponModel(
      {this.code, this.discount, this.remainedQuantity, this.isAvailable});

  CouponModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    discount = json['discount'];
    remainedQuantity = json['remainedQuantity'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['discount'] = discount;
    data['remainedQuantity'] = remainedQuantity;
    data['isAvailable'] = isAvailable;
    return data;
  }
}
