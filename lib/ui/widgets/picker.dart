import 'package:flutter/material.dart';

class Picker {
  Future<DateTime?> birthDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime(2003),
        firstDate: DateTime(1900),
        lastDate: DateTime(2004),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              primarySwatch: Colors.orange,
              splashColor: Colors.black,
              textTheme: const TextTheme(
                titleMedium: TextStyle(color: Colors.black),
                labelLarge: TextStyle(color: Colors.black),
              ),
            ),
            child: child ?? const Text(''),
          );
        });
  }
}
