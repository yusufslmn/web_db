import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/view/adress.dart';
import 'package:web_db/UI/view/my_orders.dart';
import 'package:web_db/UI/view/uptade_password.dart';
import 'package:web_db/UI/view/user_info.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/state/profile_state.dart';

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
      endDrawer: DrawerEnd(data: id),
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
                  children: [
                    const UyelikBilgilerim(),
                    const PasswordChange(),
                    SizedBox(
                      width: context.width(0.5),
                      height: context.height(1),
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              collapsedShape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              subtitle: Text(DateFormat('yyyy-MM-dd hh:mm:ss')
                                  .format(orders[index].orderDate)),
                              title: Row(
                                children: [
                                  Text(
                                    "Sipariş no: ",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  Text(
                                    orders[index].orderId,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${orders[index].price} TL",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            orders[index].payment,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w100),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              children: [
                                SizedBox(
                                  height: context.height(0.4),
                                  child: ListView(
                                    children: data
                                        .map(
                                          (e) => ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  id = e;
                                                });
                                                Scaffold.of(context)
                                                    .openEndDrawer();
                                              },
                                              child: Text(e)),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Adreslerim(),
                    const Chat()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerEnd extends StatelessWidget {
  const DrawerEnd({super.key, required this.data});
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(0.4),
      height: context.height(1),
      color: Colors.green,
      child: Text(data ?? "boş geldi"),
    );
  }
}

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
