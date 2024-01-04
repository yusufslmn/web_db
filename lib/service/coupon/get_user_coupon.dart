import 'dart:convert';
import 'dart:io';
import 'package:web_db/model/coupon/coupon_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<List<CouponModel>> getUserCoupons() async {
  final response = await http.get(
    IService.url(ApiRouteName.getUserCoupons.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    if (data is List) {
      return data.map((e) => CouponModel.fromJson(e)).toList();
    } else {
      throw Exception('Kupon Yok');
    }
  } else {
    throw Exception('Kupon Yüklenemedi');
  }
}
