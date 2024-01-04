// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:web_db/u%C4%B1/view/login/login.dart';
import 'package:web_db/service/login/login_service.dart';
import 'package:web_db/service/service.dart';
import 'package:web_db/settings/route_settings.dart';

abstract class StateLogin extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPrivate = true;
  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void handleLogin() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      IService.basicAuth = encodeBasic(email: email, password: password);
      changeLoading();
      if (await login(basicAuth: IService.basicAuth)) {
        IService.email = email;
        IService.password = password;
        print("success");
        changeLoading();
        IService.saveBasicAuth();
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.homeRoute,
          (route) => false,
        );
      } else {
        print("yasak ulen");
        changeLoading();
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Email Veya Parolanız Yanlış"),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("İlerle"))
                  ],
                ));
      }
    }
  }
}
