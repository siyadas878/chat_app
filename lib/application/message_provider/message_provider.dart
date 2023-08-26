import 'dart:developer';

import 'package:chat_app/domain/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageCreationProvider extends ChangeNotifier{

  final TextEditingController messageController = TextEditingController();

  Future<void> addMessage(String fromId) async {
     
     String userId=FirebaseAuth.instance.currentUser!.uid;
     String messageId= DateTime.now().millisecondsSinceEpoch.toString();

    try {
      MessageModel message = MessageModel(
        fromId: fromId,
        message: messageController.text,
        messageId: messageId,
        time: DateTime.now().toString(),
        userId: userId);

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('chat');

      Map<String, dynamic> messageData = message.toJson();

      await usersCollection.doc(userId).collection(userId+fromId).doc(messageId).set(messageData);
    } catch (error) {
      log("Error adding user: $error");
    }
  }
}