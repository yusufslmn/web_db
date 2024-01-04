// ignore_for_file: avoid_print
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/service/service.dart';

Future<bool> emptyBasket() async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.emptyBasket.name),
      headers: IService.basicHeader,
    );

    if (response.statusCode == 200) {
      print('sepeti boşalttım');
    }
    return response.statusCode == HttpStatus.ok;
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
