// ignore_for_file: avoid_print

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> getCoupon(String? code) async {
  final response = await http.get(
    Uri.parse('${IService.baseUrl}Coupon/GetCoupon?code=$code'),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    print("kupon eklendi");
    return true;
  } else {
    throw Exception('kupon yüklenemedi');
  }
}
