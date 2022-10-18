import 'package:flutter/material.dart';

class CustomCheckbox {
  static SizedBox unChecked() {
    return SizedBox(
        height: 20,
        width: 20,
        child: Image.asset('assets/icons/grey_check.png'));
  }


  static SizedBox checked() {
    return SizedBox(
      height: 20,
      width: 20,
      child: Image.asset(
          'assets/icons/check.png'),
    );
  }

}
