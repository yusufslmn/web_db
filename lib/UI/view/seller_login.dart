// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/UI/view/seller_panel.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/service/login/login_service.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/settings/route_settings.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({super.key});

  @override
  State<SellerLogin> createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      changeLoading();
      if (await login(basicAuth: IService.basicAuth)) {
        IService.email = email;
        IService.password = password;
        print("success");
        changeLoading();
        pushToPage(context, const SellerPanel());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Text(
                        "Hepsibunda Mağaza Paneli",
                        style: GoogleFonts.poppins(
                          color: PColors.mainColor,
                          fontSize: context.height(0.035),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 4),
                      Container(
                        padding: const EdgeInsets.all(50),
                        width: context.width(0.3),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            SizedBox(
                              width: context.width(0.25),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: PColors.mainColor))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: context.width(0.25),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: isPrivate,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPrivate = !isPrivate;
                                          });
                                        },
                                        icon: isPrivate
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off)),
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: PColors.mainColor))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return '6 karakterden uzun şifre giriniz';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: context.width(0.25),
                              height: context.height(0.07),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor: PColors.mainColor),
                                onPressed: handleLogin,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }
}
