import 'package:complaint_raiser/constants/app_themes.dart';
import 'package:flutter/material.dart';

Widget positionedButton(
    {double? top,
    double? left,
    required IconData icon,
    double? right,
    void Function()? onPressed}) {
  return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: AppThemes.tertiaryColor),
            color: AppThemes.light,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: 18,
        ),
      ));
}
