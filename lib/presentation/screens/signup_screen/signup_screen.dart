import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/contants.dart';
import '../../widgets/teal_button.dart';
import '../../widgets/text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create your account',
              style: TextStyle(color: tealColor, fontSize: 13),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              width: size.width * 0.3,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: tealColor),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  child: ClipOval(
                    child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.userTie,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'name'),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'email'),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'Password', obscureText: false),
            SizedBox(height: size.height * 0.03),
            TealLoginButton(
              onPressed: () async {},
              text: 'Sign Up',
              isLoading: false,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Let’s go to, '),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: tealColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
