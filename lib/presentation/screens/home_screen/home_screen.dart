import 'dart:async';

import 'package:chat_app/application/home_list_provider/home_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/contants.dart';
import '../../widgets/appbar_text.dart';
import '../../widgets/warnig_snackbar.dart';
import '../login_screen/login_screen.dart';
import '../message_screen/message_screen.dart';
import 'widgets/floating_button.dart';
import '../update_screen/update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(size: 30, head: 'Messenger'),
        backgroundColor: tealColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              child: const Icon(FontAwesomeIcons.ellipsisVertical),
              onSelected: (value) {
                if (value == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateScreen(),
                      ));
                } else if (value == 1) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Do you want to LogOut?'),
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
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    'LogOut',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height*0.02,),
            Expanded(
              child: Consumer<HomeListProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<void>(
                    future: value.getAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      } else {
                        final userList = value.allusers;
            
                        if (userList.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }
            
                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            final user = userList[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      fromId: user.uid.toString(),
                                      title: user.name!,
                                      imageUrl: user.imgpath!,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user.imgpath.toString()),
                              ),
                              title: Text(user.name!),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
