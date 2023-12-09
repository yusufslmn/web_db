import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/core/settings/route_settings.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'HepsiOnda',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: routeSettings,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

//ana sayfa
//ürün detay
//sepet
//profil sayfası
// arama sayfası
// kategori sayfası


