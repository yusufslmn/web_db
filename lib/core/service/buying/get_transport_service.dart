// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/model/buying/get_transport_model.dart';
import 'package:web_db/core/service/service.dart';

Future<List<GetTransportModel>> fetchTransportItem() async {
  final response = await http.get(
    IService.url(ApiRouteName.getTransportMethods.name),
    headers: IService.basicHeader,
  );
  if (response.statusCode == HttpStatus.ok) {
    final data = jsonDecode(response.body);
    print(data);
    if (data is List) {
      return data.map((e) => GetTransportModel.fromJson(e)).toList();
    } else {
      throw Exception('items boş geldi lo');
    }
  } else {
    throw Exception('transport item yüklenemedi');
  }
}
