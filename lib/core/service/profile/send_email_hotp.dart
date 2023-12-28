// ignore_for_file: avoid_print

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> sendMailHotp() async {
  try {
    final response = await http.get(
      IService.url(ApiRouteName.sendMailHOTP.name),
      headers: IService.basicHeader,
    );
    if (response.statusCode == 200) {
      print("mail yollandı");
      return response.statusCode == HttpStatus.ok;
    }
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
