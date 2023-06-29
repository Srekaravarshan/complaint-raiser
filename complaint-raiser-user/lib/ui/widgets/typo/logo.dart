import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logo() {
  return RichText(
    text: TextSpan(
        style: GoogleFonts.merienda(
            fontSize: 32, fontWeight: FontWeight.bold, color: AppThemes.dark),
        children: [
          const TextSpan(text: 'Complaint'),
          TextSpan(
              text: ' Raiser',
              style: GoogleFonts.merienda(
                  // fontSize: 30,
                  // fontWeight: FontWeight.bold,
                  color: AppThemes.primaryColor)),
        ]),
  );
}
