import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/service/service.dart';

class Adreslerim extends StatefulWidget {
  const Adreslerim({super.key});

  @override
  State<Adreslerim> createState() => _AdreslerimState();
}

class _AdreslerimState extends State<Adreslerim> {
  final TextEditingController controllerAdress = TextEditingController();
  final String adress =
      "Karadeniz Teknik Üniversitesi, 61080, Trabzon, Türkiye";
  void getAdress() async {
    await FirebaseFirestore.instance
        .collection("addres")
        .doc(IService.basicAuth)
        .get()
        .then((value) =>
            controllerAdress.text = value.data()?['addres'] ?? adress);
  }

  @override
  void initState() {
    getAdress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
              maxLines: 7,
              controller: controllerAdress,
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
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('addres')
                      .doc(IService.basicAuth)
                      .set({'addres': controllerAdress.text});
                  setState(() {});
                },
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
