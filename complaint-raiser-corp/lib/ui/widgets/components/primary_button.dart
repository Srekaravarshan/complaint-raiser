import 'package:flutter/material.dart';

import '../../../constants/app_themes.dart';

Widget primaryButton(
    {required String title,
    void Function()? onPressed,
    Color color = AppThemes.primaryColor}) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(color)),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppThemes.light),
        )),
  );
}
