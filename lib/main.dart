import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_db/UI/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConfig.apiKey,
            appId: FirebaseConfig.appId,
            messagingSenderId: FirebaseConfig.messagingSenderId,
            projectId: FirebaseConfig.projectId,
            storageBucket: FirebaseConfig.storageBucket,
            authDomain: FirebaseConfig.authDomain));
  } else {
    await Firebase.initializeApp();
  }
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
      home: const Login(),
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

class FirebaseConfig {
  static String apiKey = "AIzaSyATmDFkAPJRLZJ2ybDJmcIwTM2DCCeHPVM";
  static String authDomain = "hepsionda-4fbe1.firebaseapp.com";
  static String projectId = "hepsionda-4fbe1";
  static String storageBucket = "hepsionda-4fbe1.appspot.com";
  static String messagingSenderId = "368324946334";
  static String appId = "1:368324946334:web:0a94961d2803412c434e8f";
}
