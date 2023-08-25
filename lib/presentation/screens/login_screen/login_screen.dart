import 'package:chat_app/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/contants.dart';
import '../../widgets/teal_button.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title:const Text('LogIn'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.message,
              color: tealColor,
              size: 100,
            ),
            SizedBox(height: size.height * 0.07),
            const Text(
              'Create your account',
              style: TextStyle(color: tealColor, fontSize: 13),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'email'),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'Password', obscureText: false),
            SizedBox(height: size.height * 0.03),
            TealLoginButton(
              onPressed: () async {},
              text: 'LogIn',
              isLoading: false,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don’t have account? Let’s '),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: tealColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
