import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/service/chat/support_chat_service.dart';
import 'package:web_db/u%C4%B1/view/home/support_chat.dart';
import 'package:web_db/utility/colors.dart';

class AdminMessages extends StatefulWidget {
  const AdminMessages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<AdminMessages> createState() => _MessagesState();
}

class _MessagesState extends State<AdminMessages> {
  final SupportChatService _chatService = SupportChatService();
  String? userImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: PColors.productBackContainer,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            title: Text(
              "Mesajlarım",
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
          body: _buildMessageList()),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getAdminMessagesSupport(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Mesajiniz bulunmamaktadir!"),
            );
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ListTile(
        tileColor: PColors.mainColor,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SupportChatPage(
                  chatId: data["chatId"],
                ))),
        trailing: const Icon(CupertinoIcons.arrow_turn_down_right,
            color: Colors.white, size: 30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: PColors.mainColor)),
        title: Text(
          data["chatId"],
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}
