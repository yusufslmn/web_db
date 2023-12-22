import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<bool> login({required String basicAuth}) async {
  final url = Uri.parse('https://ditsat.com/api/Login/CheckUser');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': basicAuth
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    return response.statusCode == HttpStatus.ok;
  } on HttpException catch (e) {
    print(e.message);
  }
  return false;
}

String decodeEmailPassword({required String email, required String password}) {
  return base64.encode(utf8.encode('$email:$password'));
}
