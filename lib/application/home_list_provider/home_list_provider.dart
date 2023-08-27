import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/user_model/user_model.dart';

class HomeListProvider extends ChangeNotifier {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  List<UserModel> allusers = [];
  bool isLoading = false;

  Future<void> getAllUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      var userCollectionSnapshot =
          await FirebaseFirestore.instance.collection('chat').get();

      List<Map<String, dynamic>> userListData =
          userCollectionSnapshot.docs.map((doc) => doc.data()).toList();

      List<UserModel> newUserList = [];
      Set<String> addedUserIds = {};

      QuerySnapshot userUIDsSnapshot =
          await FirebaseFirestore.instance.collection('uids').get();
      List<DocumentSnapshot> uidDocuments = userUIDsSnapshot.docs;

      for (var userData in userListData) {
        if (userData['fromId'] == userId || userData['userId'] == userId) {
          for (var i = 0; i < uidDocuments.length; i++) {
            var uid = uidDocuments[i]['uid'];

            if (uid != userId) {
              DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .get();
              Map<String, dynamic> userData =
                  userSnapshot.data() as Map<String, dynamic>;

              if (!addedUserIds.contains(uid)) {
                UserModel user = UserModel.fromJson(userData);
                newUserList.add(user);
                addedUserIds.add(uid);
              }
            }
          }
        }
      }

      allusers = newUserList;
      isLoading = false;
      notifyListeners();

    } catch (error) {
      log("Error fetching users: $error");
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
