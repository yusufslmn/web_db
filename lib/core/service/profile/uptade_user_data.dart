// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_db/core/model/profile/profile_modal.dart';
import 'package:web_db/core/service/service.dart';

Future<bool> updateUserData(UserDataModel model) async {
  try {
    final response = await http.post(
      IService.url(ApiRouteName.updateUserData.name),
      headers: IService.basicHeader,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      print("updated profile");
      return response.statusCode == HttpStatus.ok;
    }
  } on Exception catch (e) {
    print(e);
  }
  return false;
}
