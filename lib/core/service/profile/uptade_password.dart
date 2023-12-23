import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> uptadePassword(String oldPassword, String newPassword) async {
  final url = Uri.parse('${IService.baseUrl}/Login/UptadePassword');

  final headers = {
    'Content-Type': 'application/json',
  };
  try {
    final response = await http.post(
      url,
      headers: headers,
      body:
          jsonEncode({"oldPassword": oldPassword, "newPassword": newPassword}),
    );
    if (response.statusCode == 200) {
      print('password değiştirilidi');
    }
    return response.statusCode == HttpStatus.created;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
