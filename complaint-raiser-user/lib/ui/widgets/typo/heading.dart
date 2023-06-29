import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:flutter/material.dart';

Widget heading(String text, {Color color = AppThemes.dark}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900),
  );
}

Widget heading2(String text, {Color color = AppThemes.dark}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600),
  );
}
