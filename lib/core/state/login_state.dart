// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/UI/view/login.dart';
import 'package:web_db/core/service/login/login_service.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/settings/route_settings.dart';

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
        pushToPage(context, const Home());
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
