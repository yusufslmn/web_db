import 'package:flutter/material.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        width: context.width(0.2),
        alignment: Alignment.center,
        height: context.height(0.3),
        child: Text("${index + 1}. yorum"),
        color: Colors.yellowAccent,
      ),
    );
  }
}
