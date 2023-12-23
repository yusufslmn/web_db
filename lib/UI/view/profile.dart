import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/extra/helper.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/view/adress.dart';
import 'package:web_db/UI/view/my_orders.dart';
import 'package:web_db/UI/view/uptade_password.dart';
import 'package:web_db/UI/view/user_info.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/state/profile_state.dart';
import 'dart:math' as math;

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ProfileState with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopAppBar(),
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: const Text(
                  "Kullanıcı Bilgilerim",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: context.width(0.5),
                child: TabBar(
                    onTap: (value) {
                      pageController.animateToPage(value,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear);
                    },
                    dividerColor: PColors.mainColor,
                    labelColor: PColors.mainColor,
                    indicatorColor: PColors.mainColor,
                    controller: TabController(length: 5, vsync: this),
                    tabs: const [
                      Text("Üyelik Bilgilerim"),
                      Text("Şifre Değişikliği"),
                      Text("Siparişlerim"),
                      Text("Adreslerim"),
                      Text("Müşteri Hizmetleri")
                    ]),
              ),
              SizedBox(
                width: context.width(0.5),
                height: context.height(1),
                child: PageView(
                  controller: pageController,
                  children: pageList,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> pageList = [
  const UyelikBilgilerim(),
  const PasswordChange(),
  const MyOrders(),
  const Adreslerim(),
  const Chat()
];

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
