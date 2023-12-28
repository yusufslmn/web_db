import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/profile/profile_modal.dart';
import 'package:web_db/core/service/profile/get_user_data.dart';
import 'package:web_db/core/service/profile/send_email_hotp.dart';
import 'package:web_db/core/service/profile/uptade_user_data.dart';
import 'package:web_db/core/service/profile/verify_email_hotp.dart';
import 'package:web_db/core/service/service.dart';

class UyelikBilgilerim extends StatefulWidget {
  const UyelikBilgilerim({
    super.key,
  });

  @override
  State<UyelikBilgilerim> createState() => _UyelikBilgilerimState();
}

class _UyelikBilgilerimState extends State<UyelikBilgilerim> {
  bool isUptade = false;
  bool? initalGender;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  ExpansionTileController expansionTileController = ExpansionTileController();

  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;

  UserDataModel? userDataModel;
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _changeLoading2() {
    setState(() {
      _isLoading2 = !_isLoading2;
    });
  }

  void _changeLoading3() {
    setState(() {
      _isLoading3 = !_isLoading3;
    });
  }

  Future<void> fetchData() async {
    _changeLoading();
    userDataModel = await getUserData();
    nameController.text = userDataModel?.name ?? "hata";
    surnameController.text = userDataModel?.surname ?? "hata";
    emailController.text = IService.email;
    initalGender = userDataModel?.isMale;
    _changeLoading();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        if (value == userDataModel?.name) {
                          isUptade = false;
                        } else {
                          isUptade = true;
                        }
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                        label: const Text("Ad"),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: surnameController,
                    onChanged: (value) {
                      setState(() {
                        if (value == userDataModel?.surname) {
                          isUptade = false;
                        } else {
                          isUptade = true;
                        }
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                        label: const Text("Soyad"),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        if (value == IService.email) {
                          isUptade = false;
                        } else {
                          isUptade = true;
                        }
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                        label: const Text("Email"),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    maxLines: 1,
                    initialValue: initalGender! ? "Erkek" : "Kadın",
                    enabled: false,
                    decoration: InputDecoration(
                      label: const Text("Cinsiyet"),
                      isDense: true,
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: PColors.mainColor),
                          borderRadius: BorderRadius.circular(16)),
                    )),
              ),
              userDataModel?.isVerified == true
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: const Text('Email Doğrula'),
                        controller: expansionTileController,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(8)),
                        trailing: _isLoading2
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : TextButton(
                                onPressed: () async {
                                  _changeLoading2();
                                  await sendMailHotp();
                                  _changeLoading2();
                                  expansionTileController.expand();
                                },
                                child:
                                    const Text("Email Doğrulama Kodu Gönder"),
                              ),
                        collapsedShape: RoundedRectangleBorder(
                            side: const BorderSide(color: PColors.mainColor),
                            borderRadius: BorderRadius.circular(16)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: verifyController,
                              decoration: InputDecoration(
                                  hintText: "Doğrulama Kodu",
                                  suffixIcon: _isLoading3
                                      ? const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : TextButton.icon(
                                          onPressed: () async {
                                            _changeLoading3();
                                            await verifyMailHotp(
                                                    verifyController.text)
                                                .then((value) {
                                              if (value) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    actions: [
                                                      Center(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "Devam Et")),
                                                      )
                                                    ],
                                                    title: Text(
                                                        "Doğrulama başarılı"),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    actions: [
                                                      Center(
                                                        child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "Tekrar Deneyiniz")),
                                                      )
                                                    ],
                                                    title: Text(
                                                        "Doğrulama başarısız"),
                                                  ),
                                                ).whenComplete(() async {
                                                  setState(() {});
                                                  await fetchData();
                                                });
                                              }
                                            });
                                            _changeLoading3();
                                          },
                                          icon: const Icon(Icons.send),
                                          label: const Text("Kodu Doğrula"),
                                        )),
                            ),
                          )
                        ],
                      ),
                    ),
              Center(
                child: SizedBox(
                  width: context.width(0.064),
                  child: isUptade
                      ? ElevatedButton(
                          onPressed: () async {
                            _changeLoading();
                            UserDataModel userDataModel2 = UserDataModel(
                                birthDate: userDataModel?.birthDate,
                                email: IService.email,
                                isMale: userDataModel?.isMale,
                                name: nameController.text,
                                surname: surnameController.text);
                            await updateUserData(userDataModel2)
                                .then((value) async {
                              if (value) {
                                await fetchData();
                              }
                            });
                            _changeLoading();
                          },
                          child: const Text(
                            "Güncelle",
                          ))
                      : const SizedBox.shrink(),
                ),
              )
            ],
          );
  }
}
