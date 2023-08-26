import 'dart:developer';
import 'dart:io';
import 'package:chat_app/domain/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../application/profile_data_provider/get_profile_data.dart';
import '../../../application/profile_data_provider/update_profile.dart';
import '../../../application/sign_up_provider/imagepicker_provider.dart';
import '../../../core/contants.dart';
import '../../widgets/teal_button.dart';
import '../../widgets/text_field.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var uid = FirebaseAuth.instance.currentUser!.uid.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<ImageProviderClass>(
          create: (context) => ImageProviderClass(),
          child: Consumer<ImageProviderClass>(
            builder: (context, imagepic, _) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      const Text(
                        'Update Profile',
                        style: TextStyle(color: tealColor, fontSize: 13),
                      ),
                      SizedBox(height: size.height * 0.07),
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
                                    : FutureBuilder<UserModel?>(
                                        future:
                                            GetProfileData().getUserData(uid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else if (!snapshot.hasData) {
                                            return const Center(
                                                child: Text('User not found'));
                                          }

                                          final UserModel user = snapshot.data!;
                                          return Image.network(
                                            user.imgpath.toString(),
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        // child:
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.07),
                      RoundedTealTextFormField(
                          controller:
                              context.read<UpdateProvider>().nameController,
                          labelText: "name"),
                      SizedBox(height: size.height * 0.07),
                      TealLoginButton(
                          onPressed: () async {
                            print(imagepic.imageUrl.toString());
                            try {
                              context.read<UpdateProvider>().updatedetails(
                                  context,
                                  imagepic.imageUrl.toString(),
                                  context
                                      .read<UpdateProvider>()
                                      .nameController
                                      .text,
                                  context
                                      .read<UpdateProvider>()
                                      .usernameController
                                      .text);
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          text: 'Update',
                          isLoading:
                              Provider.of<UpdateProvider>(context).isLoading),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
