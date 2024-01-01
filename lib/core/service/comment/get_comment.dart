import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/product/product_comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<List<ProductCommentModel>> fetchProductComment(
    int id, bool orderByDate) async {
  final response = await http.get(
    Uri.parse(
        '${IService.baseUrl}Product/GetComments?productId=$id&orderByDate=$orderByDate'),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    print(data);
    if (data is List) {
      return data.map((e) => ProductCommentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  } else {
    throw Exception('Failed to load products');
  }
}
