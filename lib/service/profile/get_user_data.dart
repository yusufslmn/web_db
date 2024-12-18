// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_db/model/profile/profile_modal.dart';
import 'package:web_db/service/service.dart';

Future<UserDataModel?> getUserData() async {
  try {
    final response = await http.get(
      IService.url(ApiRouteName.getUserData.name),
      headers: IService.basicHeader,
    );
    if (response.statusCode == 200) {
      print("geldi profil datan looo");
      return UserDataModel.fromJson(jsonDecode(response.body));
    }
  } on Exception catch (e) {
    print(e);
  }
  return null;
}
