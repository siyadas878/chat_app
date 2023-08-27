import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../application/profile_data_provider/get_profile_data.dart';
import '../../../core/contants.dart';
import '../../../domain/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<UserModel?>(
            future: GetProfileData().getUserData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Center(child: Text('User not found'));
              }

              final UserModel user = snapshot.data!;
              return Container(
                height: size.height * 0.4,
                decoration:const BoxDecoration(
                  color: tealColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(user.imgpath.toString()),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        user.name.toString(),
                        style:const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.03),
          
         const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Welcome to our user-friendly chat app! Sign up, log in, and chat with ease. Connect and converse seamlessly - your new chat adventure begins here!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          ListTile(
            leading:const Icon(FontAwesomeIcons.user),
            title:const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:const Icon(Icons.settings),
            title:const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
