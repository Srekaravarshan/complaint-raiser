import 'package:complaint_raiser/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

Widget dataText(String key, String value) {
  return Row(
    children: [
      subText(key),
      SizedBox(width: 10),
      heading(value),
    ],
  );
}
