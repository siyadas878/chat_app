import 'package:chat_app/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../application/login_provider/login_provider.dart';
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
        title: const Text('LogIn'),
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
            RoundedTealTextFormField(labelText: 'email',
            controller: context.read<LoginProvider>().emailController,),
            SizedBox(height: size.height * 0.03),
            RoundedTealTextFormField(labelText: 'Password',
            controller: context.read<LoginProvider>().passwordController
            , obscureText: false),
            SizedBox(height: size.height * 0.03),
            TealLoginButton(
              onPressed: () async {
                final loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);

                loginProvider.loginUser(context);
              },
              text: 'LogIn',
              isLoading: Provider.of<LoginProvider>(context).isLoading,
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
