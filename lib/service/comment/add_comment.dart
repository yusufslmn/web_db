// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/model/comment/post_comment_model.dart';
import 'package:web_db/service/service.dart';

Future<bool> postComment(PostCommentModel comment) async {
  final response = await http.post(IService.url(ApiRouteName.addComment.name),
      headers: IService.basicHeader, body: jsonEncode(comment.toJson()));
  if (response.statusCode == HttpStatus.ok) {
    print("yorum gitti");
    return true;
  } else {
    throw Exception('yorum gitmedi');
  }
}
