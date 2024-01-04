// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<bool> verifyMailHotp(String code) async {
  try {
    final response = await http.post(
        IService.url(ApiRouteName.verifyMailHOTP.name),
        headers: IService.basicHeader,
        body: jsonEncode({'code': code}));
    if (response.statusCode == 200) {
      print("code yollandı");
      return response.statusCode == HttpStatus.ok;
    }
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
