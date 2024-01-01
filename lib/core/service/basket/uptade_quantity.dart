// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_db/core/model/basket/uptade_quantity.dart';
import 'package:web_db/core/service/service.dart';

Future<bool> uptadeQuantity(UptadeQuantity uptadeQuantity) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.updateQuantity.name),
      headers: IService.basicHeader,
      body: jsonEncode(uptadeQuantity.toJson()),
    );

    if (response.statusCode == 200) {
      print('ürün sayısı güncellendi');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
