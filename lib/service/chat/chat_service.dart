import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_db/service/service.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // SEND Message
  Future<void> sendMessage(String chatId, String message) async {
    //get current user info
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
        senderId: IService.basicAuth, message: message, timestamp: timestamp);
    // ignore: no_leading_underscores_for_local_identifiers
    await _db.collection("chats").doc(chatId).set({
      'chatId': chatId,
    });
    await _db
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .add(newMessage.toMap());
  }

// get messages
  Stream<QuerySnapshot> getMessages(String chatId) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getAdminMessages() {
    final db = FirebaseFirestore.instance;
    return db.collection("chats").snapshots();
  }
}

class Message {
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return Message(
      message: data["message"],
      senderId: data["senderId"],
      timestamp: data["timestamp"],
    );
  }
}
