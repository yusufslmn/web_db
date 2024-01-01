// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/model/order/order_model.dart';
import 'package:web_db/core/service/service.dart';

Future<List<OrderModel>> fetchOrder() async {
  final response = await http.get(
    IService.url(ApiRouteName.getOrder.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    print(data);
    if (data is List) {
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('liste boşş loo');
    }
  } else {
    throw Exception('order yüklenemedi');
  }
}
