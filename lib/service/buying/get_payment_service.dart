// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/model/buying/get_payment_model.dart';
import 'package:web_db/service/service.dart';

Future<List<GetPaymentModel>> fetchPaymentItem() async {
  final response = await http.get(
    IService.url(ApiRouteName.getPaymentMethods.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    if (data is List) {
      return data.map((e) => GetPaymentModel.fromJson(e)).toList();
    } else {
      throw Exception('items boş geldi lo');
    }
  } else {
    throw Exception('paymetns items yüklenemedi');
  }
}
