// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:web_db/core/model/basket/add_basket_modal.dart';
import 'package:http/http.dart' as http;
import 'package:web_db/core/service/service.dart';

Future<bool> addToBasket(AddBasketModel addBasketModel) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.addToBasket.name),
      headers: IService.basicHeader,
      body: jsonEncode(addBasketModel.toJson()),
    );

    if (response.statusCode == 200) {
      print('ürün eklendi');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
