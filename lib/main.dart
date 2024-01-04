import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_db/u%C4%B1/view/admin/admin_login.dart';
import 'package:web_db/u%C4%B1/view/admin/admin_panel.dart';
import 'package:web_db/u%C4%B1/view/basket/basket.dart';
import 'package:web_db/u%C4%B1/view/home/home.dart';
import 'package:web_db/u%C4%B1/view/login/forget_password.dart';
import 'package:web_db/u%C4%B1/view/login/login.dart';
import 'package:web_db/u%C4%B1/view/login/register.dart';
import 'package:web_db/u%C4%B1/view/profile/profile.dart';
import 'package:web_db/service/service.dart';
import 'package:web_db/settings/route_settings.dart';

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
  IService.loadBasicAuth();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hepsionda',
      initialRoute: Routes.loginRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.homeRoute: (context) => const Home(),
        Routes.loginRoute: (context) => const Login(),
        Routes.profileRoute: (context) => const Profile(),
        Routes.basketRoute: (context) => const Basket(),
        Routes.registerRoute: (context) => const RegistrationScreen(),
        Routes.forgetPassword: (context) => const ForgetPassword(),
        Routes.adminPanel: (context) => const SellerPanel(),
        Routes.adminLoginRoute: (context) => const SellerLogin(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
    );
  }
}

//admin panel
//admin chat // chat ıd
//admin product // category id, categoryname
//admin products comments // product ıd
//buying page // totalPrice
//compare // id1 ,id2 ,isShow
//login
//register
//seller login
// home page
// product detail / productid
// basket
// profile
// forget password
// category //category id ,category name

class FirebaseConfig {
  static String apiKey = "AIzaSyATmDFkAPJRLZJ2ybDJmcIwTM2DCCeHPVM";
  static String authDomain = "hepsionda-4fbe1.firebaseapp.com";
  static String projectId = "hepsionda-4fbe1";
  static String storageBucket = "hepsionda-4fbe1.appspot.com";
  static String messagingSenderId = "368324946334";
  static String appId = "1:368324946334:web:0a94961d2803412c434e8f";
}
