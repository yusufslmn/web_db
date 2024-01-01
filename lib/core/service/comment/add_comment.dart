import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/model/comment/post_comment_model.dart';
import 'package:web_db/core/service/service.dart';

Future<bool> postComment(PostCommentModel comment) async {
  final response = await http.post(IService.url(ApiRouteName.addComment.name),
      headers: IService.basicHeader, body: jsonEncode(comment.toJson()));
  if (response.statusCode == HttpStatus.ok) {
    return true;
  } else {
    throw Exception('Failed to load products');
  }
}
