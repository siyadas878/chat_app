import 'package:chat_app/core/contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/warnig_snackbar.dart';
import '../login_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
        backgroundColor: tealColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              child:const Icon(FontAwesomeIcons.ellipsisVertical),
              onSelected: (value) {
                if (value == 1) {
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
                                    builder: (context) => const LoginScreen()),
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
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: 0,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                const PopupMenuItem(
                    value: 1,
                    child: Text(
                      'LogOut',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
          )
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
