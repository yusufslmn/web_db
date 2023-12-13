import 'package:flutter/material.dart';
import 'package:web_db/UI/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HepsiOnda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade300),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

//ana sayfa
//ürün detay
//sepet
//profil sayfası
// arama sayfası
// kategori sayfası


