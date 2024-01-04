// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<bool> postCommentRating(int commentId, double rating) async {
  final response = await http.post(
      IService.url(ApiRouteName.addOrUpdateCommentRating.name),
      headers: IService.basicHeader,
      body: jsonEncode({'commentId': commentId, 'rating': rating}));
  if (response.statusCode == HttpStatus.ok) {
    print("comment rating yollandı");
    return true;
  } else {
    throw Exception('Failed to load products');
  }
}
