import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/service/chat/chat_service.dart';
import 'package:web_db/core/service/service.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String chatId;
  const ChatPage({super.key, required this.chatId});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController controllerList = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void getEnd() async {
    await controllerList.animateTo(controllerList.position.maxScrollExtent,
        curve: Curves.easeOut, duration: const Duration(seconds: 1));
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService
          .sendMessage(widget.chatId, _messageController.text)
          .then((value) async {})
          .whenComplete(() => _messageController.clear());
      getEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: PColors.productBackContainer,
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Canlı Destek",
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                backgroundColor: Colors.transparent),
            body: SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: _buildMessageList(),
                  ),
                  _buildMessageInput()
                ],
              ),
            )));
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.chatId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Future.delayed(
          const Duration(microseconds: 300),
          () => getEnd(),
        );
        return ListView(
          dragStartBehavior: DragStartBehavior.down,
          controller: controllerList,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var aligment = (data["senderId"] == IService.basicAuth)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final Timestamp time = data['timestamp'];
    final List<Widget> left = [
      const CircleAvatar(backgroundColor: Colors.blueGrey),
      const SizedBox(
        width: 5,
      ),
      Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: PColors.mainColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: (data["senderId"] == IService.basicAuth)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                data["message"],
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                "${time.toDate().hour.toString()} :${time.toDate().minute.toString()} ",
                style: const TextStyle(fontSize: 10),
              )
            ],
          )),
    ];
    final List<Widget> right = [
      Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: PColors.mainColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: (data["senderId"] == IService.basicAuth)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                data["message"],
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                "${time.toDate().hour.toString()} :${time.toDate().minute.toString()} ",
                style: const TextStyle(fontSize: 10),
              )
            ],
          )),
      const SizedBox(
        width: 5,
      ),
      const CircleAvatar(
        backgroundColor: Colors.blueGrey,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: aligment,
        child: Row(
            mainAxisAlignment: (data["senderId"] == IService.basicAuth)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: (data["senderId"] == IService.basicAuth) ? right : left),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _messageController,
                onEditingComplete: sendMessage,
                style: GoogleFonts.poppins(color: Colors.black),
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: PColors.mainColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: PColors.mainColor)),
                    hintText: 'Enter message...',
                    suffixIcon: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(
                          CupertinoIcons.arrow_turn_down_right,
                          size: 40,
                          color: PColors.mainColor,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: PColors.mainColor))),
              )),
        )
      ],
    );
  }
}
