import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../domain/user_model/user_model.dart';

class UpdateUser extends ChangeNotifier {
  UserModel? data;
  UpdateUser({this.data});

  Future<void> updateUserDetails(UserModel data) async {
    try {
      UserModel user = UserModel(
        name: data.name,
        imgpath: data.imgpath,
        email: data.email,
        uid: data.uid
      );

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      String userId = FirebaseAuth.instance.currentUser!.uid;

      Map<String, dynamic> userData = user.toJson();

      await usersCollection.doc(userId).update(userData);
    } catch (error) {
      log("Error adding/updating user: $error");
    }
  }
}
