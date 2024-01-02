// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> adminComment(int commentId, String comment) async {
  final response = await http.post(
      IService.url(ApiRouteName.addOrUpdateCommentResponse.name),
      headers: IService.basicHeader,
      body: jsonEncode({'commentId': commentId, 'sellerResponse': comment}));
  if (response.statusCode == HttpStatus.ok) {
    print("admin comment yollandı");
    return true;
  } else {
    throw Exception('admin yorum gitmedi');
  }
}
