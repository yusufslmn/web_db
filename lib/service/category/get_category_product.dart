import 'dart:convert';
import 'dart:io';
import 'package:web_db/model/product/showroom_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<List<ShowroomProduct>> fetchCategoryProduct(int categoryId) async {
  final response = await http.get(
    Uri.parse(
        '${IService.baseUrl}Product/GetCategoryProducts?categoryId=$categoryId'),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    if (data is List) {
      return data.map((e) => ShowroomProduct.fromJson(e)).toList();
    } else {
      throw Exception('liste boşş loo');
    }
  } else {
    throw Exception('Failed to load products');
  }
}
