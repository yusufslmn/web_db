// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:web_db/model/login/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<bool> register(RegisterModal registerModel) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.register.name),
      headers: IService.baseHeader,
      body: jsonEncode(registerModel.toJson()),
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
