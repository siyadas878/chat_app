import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String head;
  const AppLogo({
    Key? key,
    required this.size,
    required this.head
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      head,
      style: GoogleFonts.jollyLodger(
        fontSize: size,
      ),
    );
  }
}