import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class UyelikBilgilerim extends StatefulWidget {
  const UyelikBilgilerim({
    super.key,
  });

  @override
  State<UyelikBilgilerim> createState() => _UyelikBilgilerimState();
}

class _UyelikBilgilerimState extends State<UyelikBilgilerim> {
  bool isUptade = false;

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  bool? initalGender;
  final String name = "Yusuf";
  final String surname = "Salman";
  final String email = "yusufslmn@outlook.com.tr";
  @override
  void initState() {
    nameController.text = name;
    surnameController.text = surname;
    emailController.text = email;
    initalGender = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              controller: nameController,
              onChanged: (value) {
                setState(() {
                  if (value == name) {
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
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              controller: surnameController,
              onChanged: (value) {
                setState(() {
                  if (value == surname) {
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
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  if (value == email) {
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
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: PColors.mainColor),
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
                    borderSide: const BorderSide(color: PColors.mainColor),
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
                shape: StadiumBorder(),
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
