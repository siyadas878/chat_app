import 'package:chat_app/core/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/warnig_snackbar.dart';
import '../login_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Do yo want to LogOut'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('LOGOUT'),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false,
                            );
                          } catch (e) {
                            warning(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(child: ListView.builder(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(),
            title: Text('title'),
            subtitle: Text('subtitle'),
          );
        },
      )),
    );
  }
}
