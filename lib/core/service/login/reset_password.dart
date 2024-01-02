// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> resetPassword(String code, String email, String password) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.resetPassword.name),
      headers: IService.baseHeader,
      body: jsonEncode({'code': code, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('register success');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
