import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/UI/view/login.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/settings/route_settings.dart';

abstract class StateLogin extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    // ignore: duplicate_ignore
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      IService.basicAuth =
          'Basic ${base64Encode(utf8.encode('$email:$password'))}';
      pushToPage(context, const Home());
      // Burada gerçek bir authentication servisi kullanılmalıdır.
      // Örnek olarak şu anda sadece konsola bilgileri yazdırıyoruz.
      // Auth işlemi başarılı olduğunda, istediğin sayfaya yönlendirme yapabilirsin.
      // Örneğin:
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
