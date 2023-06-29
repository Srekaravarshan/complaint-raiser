import 'package:complaint_raiser_corp/constants/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget logo() {
  return RichText(
    text: TextSpan(
        style: GoogleFonts.merienda(
            fontSize: 32, fontWeight: FontWeight.bold, color: AppThemes.light),
        children: [
          const TextSpan(text: 'Chaat'),
          TextSpan(
              text: ' 2 ',
              style: GoogleFonts.merienda(
                  // fontSize: 30,
                  // fontWeight: FontWeight.bold,
                  color: AppThemes.primaryColor)),
          const TextSpan(text: 'Chat')
        ]),
  );
}
