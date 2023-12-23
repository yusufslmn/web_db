import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/colors.dart';

class Adreslerim extends StatefulWidget {
  const Adreslerim({super.key});

  @override
  State<Adreslerim> createState() => _AdreslerimState();
}

class _AdreslerimState extends State<Adreslerim> {
  final TextEditingController controllerAdress = TextEditingController();
  final String adress =
      "Karadeniz Teknik Üniversitesi, 61080, Trabzon, Türkiye";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
              maxLines: 7,
              initialValue: adress,
              decoration: InputDecoration(
                  label: const Text("Adresim"),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)))),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: PColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {},
                child: const Text(
                  "Güncelle",
                  style: TextStyle(color: Colors.white),
                )),
          ))
        ],
      )),
    );
  }
}
