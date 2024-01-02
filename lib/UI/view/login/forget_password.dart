// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/service/login/reset_password.dart';
import 'package:web_db/core/service/login/send_reset_password_code.dart';
import 'package:web_db/core/settings/route_settings.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool isPrivate = true;
  bool isLoading = false;
  bool isShow = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void sendCode() async {
    if (formKey.currentState!.validate()) {
      changeLoading();
      await sendResetPasswordCode(emailController.text).then((value) {
        if (value) {
          setState(() {
            isShow = true;
          });
        }
      });
      changeLoading();
    }
  }

  void postPassword() async {
    if (formKey.currentState!.validate()) {
      changeLoading();
      if (await resetPassword(
          codeController.text, emailController.text, passwordController.text)) {
        print("success");
        changeLoading();
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginRoute,
          (route) => false,
        );
      } else {
        print("yasak ulen");
        changeLoading();
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Sıfırlama Başarısız Tekrar Deneyiniz"),
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
                key: formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Text(
                        "Şifremi Unuttum",
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
                            isShow
                                ? SizedBox(
                                    width: context.width(0.25),
                                    child: TextFormField(
                                      controller: codeController,
                                      decoration: InputDecoration(
                                          labelText: 'Code',
                                          prefixIcon: const Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: PColors.mainColor))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter code';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 16),
                            isShow
                                ? SizedBox(
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
                                                  : const Icon(
                                                      Icons.visibility_off)),
                                          prefixIcon: const Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 16),
                            isShow
                                ? SizedBox(
                                    width: context.width(0.25),
                                    child: TextFormField(
                                      controller: rePasswordController,
                                      obscureText: isPrivate,
                                      decoration: InputDecoration(
                                          labelText: 'RePassword',
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPrivate = !isPrivate;
                                                });
                                              },
                                              icon: isPrivate
                                                  ? const Icon(Icons.visibility)
                                                  : const Icon(
                                                      Icons.visibility_off)),
                                          prefixIcon: const Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                  color: PColors.mainColor))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value.length < 6) {
                                          return '6 karakterden uzun şifre giriniz';
                                        }
                                        if (value != passwordController.text) {
                                          return 'Şifreler uyuşmuyor';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 16),
                            isShow
                                ? SizedBox(
                                    width: context.width(0.25),
                                    height: context.height(0.07),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: PColors.mainColor),
                                      onPressed: postPassword,
                                      child: const Text(
                                        'Sıfırla',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: context.width(0.25),
                                    height: context.height(0.07),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: PColors.mainColor),
                                      onPressed: sendCode,
                                      child: const Text(
                                        'Kod Gönder',
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
