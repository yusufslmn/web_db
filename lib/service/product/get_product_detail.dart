// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:web_db/model/product/product_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<ProductDetailModel> fetchProductDetail(int id) async {
  final response = await http.get(
    Uri.parse('${IService.baseUrl}Product/GetProduct?id=$id'),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    return ProductDetailModel.fromJson(data);
  } else {
    throw Exception('Failed to load products');
  }
}
