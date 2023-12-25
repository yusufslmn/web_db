// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> uptadePassword(String oldPassword, String newPassword) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.uptadePassword.name),
      headers: IService.basicHeader,
      body:
          jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword}),
    );
    if (response.statusCode == 200) {
      print('password değiştirilidi');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
