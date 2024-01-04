import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/u%C4%B1/view/profile/profile.dart';

abstract class ProfileState extends ConsumerState<Profile> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  bool private = true;
  int? id;
  final TextEditingController textEditingController = TextEditingController();
  double? rating;
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  List<ExpansionTileController> controllerEx = [];
}

class ProfileNotifier extends ChangeNotifier {}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier();
});
