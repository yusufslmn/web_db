import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/profile_modal.dart';
import 'package:web_db/core/service/profile/get_user_data.dart';
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
  bool _isLoading = false;
  UserDataModel? userDataModel;

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchData() async {
    _changeLoading();
    userDataModel = await getUserData();
    nameController.text = userDataModel?.name ?? "";
    surnameController.text = userDataModel?.surname ?? "";
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
              Center(
                child: SizedBox(
                  width: context.width(0.064),
                  child: ListTile(
                      enabled: isUptade,
                      onTap: () {},
                      textColor: Colors.white,
                      tileColor: PColors.mainColor,
                      shape: const StadiumBorder(),
                      titleAlignment: ListTileTitleAlignment.center,
                      title: const Text(
                        "Güncelle",
                      )),
                ),
              )
            ],
          );
  }
}
