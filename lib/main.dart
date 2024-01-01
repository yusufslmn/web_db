import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/basket.dart';
import 'package:web_db/UI/view/home.dart';
import 'package:web_db/UI/view/login.dart';
import 'package:web_db/UI/view/product_detail.dart';
import 'package:web_db/UI/view/profile.dart';
import 'package:web_db/UI/view/seller_panel.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hepsionda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

// ana sayfa
// ürün detay
// sepet
// profil sayfası
// arama sayfası
// kategori sayfası
//siparişlerim

