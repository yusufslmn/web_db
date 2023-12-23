import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/service/profile/uptade_password.dart';
import 'package:web_db/core/service/service.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  bool private = true;
  bool private2 = true;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Şifreniz en az bir harf, rakam veya özel karakter içermeli. Ayrıca şifreniz en az 6 karakterden oluşmalı.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text("Mevcut Şifre"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                    child: TextFormField(
                      obscureText: private,
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: private
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                private = !private;
                              });
                            },
                          ),
                          hintText: "Mevcut Şifre",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: PColors.mainColor))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        if (IService.password != oldPasswordController.text) {
                          return 'Parolanız Yanlış';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Text("Yeni Şifre"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: TextFormField(
                      obscureText: private2,
                      controller: newPasswordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: private2
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                private2 = !private2;
                              });
                            },
                          ),
                          hintText: "Yeni Şifre",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: PColors.mainColor))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        if (newPasswordController.text.length < 6) {
                          return '6 Karakterden uzun parola giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "!! Güvenliğiniz için adınız, soyadınız ve doğum tarihinizi içermeyen bir şifre belirleyin.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: context.width(0.43),
                      height: context.height(0.05),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: PColors.mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              changeLoading();
                              await uptadePassword(oldPasswordController.text,
                                      newPasswordController.text)
                                  .then((value) => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "Şifreniz Başarıyla değiştirildi"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("kaydet"))
                                          ],
                                        ),
                                      ));
                              changeLoading();
                            }
                          },
                          child: const Text(
                            "Güncelle",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
