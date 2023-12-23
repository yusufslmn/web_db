import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/login_model.dart';
import 'package:http/http.dart' as http;

Future<bool> register(LoginModel loginModel) async {
  final url = Uri.parse('https://ditsat.com/api/Login/Register');

  final headers = {
    'Content-Type': 'application/json',
  };
  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(loginModel.toJson()),
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
