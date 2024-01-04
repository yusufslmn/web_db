import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<bool> adminLogin({required String basicAuth}) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': basicAuth
  };

  try {
    final response = await http.get(
      IService.url(ApiRouteName.adminLogin.name),
      headers: headers,
    );
    return response.statusCode == HttpStatus.ok;
  } on HttpException catch (e) {
    // ignore: avoid_print
    print(e.message);
  }
  return false;
}

String encodeEmailPassword({required String email, required String password}) {
  return base64.encode(utf8.encode('$email:$password'));
}
