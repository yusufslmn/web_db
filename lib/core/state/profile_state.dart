import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/profile.dart';

abstract class ProfileState extends ConsumerState<Profile> {
  PageController pageController = PageController();
  bool private = true;
  String? id;
  final List<Order> orders = [
    Order(
        orderId: '550 403 032',
        orderDate: DateTime.timestamp(),
        price: 50.0,
        payment: "Kredi Kartı"),
    Order(
        orderId: '550 423 423',
        orderDate: DateTime.timestamp(),
        price: 15.0,
        payment: "Kredi Kartı"),
    Order(
        orderId: '344 564 524',
        orderDate: DateTime.timestamp(),
        price: 25.0,
        payment: "Kredi Kartı"),
  ];

  List<ExpansionTileController> controllerEx = [];
  List<String> data = ["1", "2", "3"];
}

class ProfileNotifier extends ChangeNotifier {}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier();
});

class Order {
  final String orderId;
  final DateTime orderDate;
  final double price;
  final String payment;

  Order(
      {required this.payment,
      required this.orderId,
      required this.orderDate,
      required this.price});
}
