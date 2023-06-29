import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_themes.dart';

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
