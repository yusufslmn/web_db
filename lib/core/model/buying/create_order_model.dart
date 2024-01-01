class CreateOrderModel {
  int? transportMethodId;
  int? paymentMethodId;
  String? couponCode;

  CreateOrderModel(
      {this.transportMethodId, this.paymentMethodId, this.couponCode});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    transportMethodId = json['transportMethodId'];
    paymentMethodId = json['paymentMethodId'];
    couponCode = json['couponCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transportMethodId'] = transportMethodId;
    data['paymentMethodId'] = paymentMethodId;
    data['couponCode'] = couponCode;
    return data;
  }
}
