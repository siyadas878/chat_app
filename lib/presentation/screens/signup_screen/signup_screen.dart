import 'dart:developer';
import 'dart:io';
import 'package:chat_app/application/sign_up_provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../application/sign_up_provider/imagepicker_provider.dart';
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
        child: Consumer<ImageProviderClass>(
          builder: (context, imagepic, child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
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
                        onTap: () => imagepic.getImageFromGallery(context),
                        child: ClipOval(
                          child: Container(
                            width: size.width * 0.3,
                            height: size.height * 0.15,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: imagepic.imgPath != null
                                ? Image.file(
                                    File(imagepic.imgPath!),
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
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
                  RoundedTealTextFormField(
                    labelText: 'name',
                    controller: context.read<SignUpProvider>().nameController,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedTealTextFormField(
                      labelText: 'email',
                      controller:
                          context.read<SignUpProvider>().emailController),
                  SizedBox(height: size.height * 0.03),
                  RoundedTealTextFormField(
                      labelText: 'Password',
                      controller:
                          context.read<SignUpProvider>().passwordController,
                      obscureText: false),
                  SizedBox(height: size.height * 0.03),
                  TealLoginButton(
                      onPressed: () async {
                        try {
                          Provider.of<SignUpProvider>(context, listen: false)
                              .signUpUser(
                                  context, imagepic.imageUrl.toString());
                          await Future.delayed(const Duration(seconds: 2));
                          // ignore: use_build_context_synchronously
                          context.read<ImageProviderClass>().clearImage();
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      text: 'Sign Up',
                      isLoading:
                          Provider.of<SignUpProvider>(context).isLoading),
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
            );
          },
          // child:
        ),
      ),
    );
  }
}
