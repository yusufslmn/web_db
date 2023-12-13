import 'package:flutter/material.dart';

class Campaign extends StatefulWidget {
  const Campaign({super.key});

  @override
  State<Campaign> createState() => _CampaingState();
}

class _CampaingState extends State<Campaign> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          title: Text("data1"),
        ),
        ListTile(
          title: Text("data1"),
        ),
        ListTile(
          title: Text("data1"),
        ),
        ListTile(
          title: Text("data1"),
        )
      ],
    );
  }
}
