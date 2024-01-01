import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/view/profile.dart';

abstract class ProfileState extends ConsumerState<Profile> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  bool private = true;
  int? id;

  List<ExpansionTileController> controllerEx = [];
}

class ProfileNotifier extends ChangeNotifier {}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier();
});
