// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/model/buying/create_order_model.dart';
import 'package:web_db/service/service.dart';

Future<bool> fetchCreateOrder(CreateOrderModel createOrderModel) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.createOrder.name),
      headers: IService.basicHeader,
      body: jsonEncode(createOrderModel.toJson()),
    );

    if (response.statusCode == 200) {
      print('sipariş oluşturuldu');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
