import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends ChangeNotifier {
  final String title = "Hepsibunda";
  final String subtitle = "Hepsibundayı";
  final String subtitle2 = " keşfet";
  final TextEditingController searchController = TextEditingController();
  final ScrollController bodyController = ScrollController();
  final ScrollController bodyController2 = ScrollController();
}

final homeProvider = ChangeNotifierProvider<HomeNotifier>((ref) {
  return HomeNotifier();
});
