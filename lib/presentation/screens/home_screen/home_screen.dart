import 'package:chat_app/presentation/screens/drawer_screen/drawer_screen.dart';
import 'package:chat_app/presentation/screens/home_screen/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../application/home_list_provider/home_list_provider.dart';
import '../../../core/contants.dart';
import '../../widgets/appbar_text.dart';
import '../../widgets/warnig_snackbar.dart';
import '../login_screen/login_screen.dart';
import '../message_screen/message_screen.dart';
import '../update_screen/update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeListProvider>().getAllUsers();
    });
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: const AppLogo(size: 30, head: 'Messenger'),
        backgroundColor: tealColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              child: const Icon(FontAwesomeIcons.ellipsisVertical),
              onSelected: (value) async {
                if (value == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateScreen(),
                    ),
                  );
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
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
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
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Consumer<HomeListProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final userList = value.allusers;

                  if (userList.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: size.height * 0.02),
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
                          backgroundImage:
                              NetworkImage(user.imgpath.toString()),
                        ),
                        title: Text(
                          user.name!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
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
