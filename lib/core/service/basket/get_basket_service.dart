import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/basket_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<BasketModal> fetchBasketItem() async {
  final response = await http.get(
    IService.url(ApiRouteName.getBasket.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    return data.map((e) => BasketModal.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
