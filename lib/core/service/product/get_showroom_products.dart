import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/showroom_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<List<ShowroomProduct>> fetchShowroomProduct() async {
  final response = await http.get(
    IService.url(ApiRouteName.getShowroomProducts.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    if (data is List) {
      return data.map((e) => ShowroomProduct.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  } else {
    throw Exception('Failed to load products');
  }
}