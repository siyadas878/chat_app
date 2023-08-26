import 'package:chat_app/presentation/screens/home_screen/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/warnig_snackbar.dart';
import '../login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    wait(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[500],
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.message,
              size: 80,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'ChatApp',
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      )),
    );
  }
}

wait(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var connectivityResult = await Connectivity().checkConnectivity();
  await Future.delayed(const Duration(milliseconds: 3700));
  if (connectivityResult == ConnectivityResult.none) {
    warning(context, 'No Interner Connection');
  }
  auth.currentUser?.uid != null
      ? Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()))
      : Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
}
