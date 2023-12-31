import 'package:chat_app/application/home_list_provider/home_list_provider.dart';
import 'package:chat_app/application/login_provider/login_provider.dart';
import 'package:chat_app/application/message_provider/message_provider.dart';
import 'package:chat_app/application/profile_data_provider/get_profile_data.dart';
import 'package:chat_app/application/profile_data_provider/update_profile.dart';
import 'package:chat_app/application/profile_data_provider/update_provider.dart';
import 'package:chat_app/application/sign_up_provider/add_user_details.dart';
import 'package:chat_app/application/sign_up_provider/imagepicker_provider.dart';
import 'package:chat_app/application/sign_up_provider/signup_provider.dart';
import 'package:chat_app/presentation/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'application/profile_data_provider/get_all_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddUserDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImageProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetProfileData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetallUsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageCreationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          fontFamily: GoogleFonts.archivoNarrow().fontFamily,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
