import 'package:chat_app/presentation/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          fontFamily: GoogleFonts.archivoNarrow().fontFamily,
          useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

