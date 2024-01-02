// ignore_for_file: avoid_print

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> sendResetPasswordCode(String email) async {
  try {
    final response = await http.get(
      Uri.parse('${IService.baseUrl}User/SendResetPasswordMail?email=$email'),
      headers: IService.baseHeader,
    );
    if (response.statusCode == 200) {
      print("code yollandı");
      return response.statusCode == HttpStatus.ok;
    }
  } on Exception catch (e) {
    print(e);
  }
  print("code yollanmadı");
  return false;
}
