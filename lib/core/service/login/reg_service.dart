import 'dart:convert';
import 'package:web_db/core/model/login_model.dart';
import 'package:http/http.dart' as http;

Future<void> register(LoginModel loginModel) async {
  final url = Uri.parse('https://ditsat.com/api/Login/Register');

  final headers = {
    'Content-Type': 'application/json',
  };
  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(loginModel.toJson()),
  );
  if (response.statusCode == 200) {
    print('Mesaj başarıyla gönderildi.');
  } else {
    print(response.body);
  }
}
