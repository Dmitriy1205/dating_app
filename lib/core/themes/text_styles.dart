import 'package:flutter/material.dart';

class CustomTextStyle {
  static bigText(String text, {String? additionalText}) {
    return Row(
      children: [
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        Text(
          additionalText != null ? '  ${additionalText.toString()}' : '',
          style: TextStyle(fontSize: 12, color: Colors.black45),
        ),
      ],
    );
  }
}
