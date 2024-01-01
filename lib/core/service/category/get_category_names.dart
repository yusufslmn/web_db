import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/category/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<List<CategoryModel>> getCategoryNames() async {
  final response = await http.get(
    IService.url(ApiRouteName.getCategories.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    if (data is List) {
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Gelmedi Categoriesler');
    }
  } else {
    throw Exception('Categories Yüklenemedi');
  }
}
