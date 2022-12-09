import 'package:flutter/material.dart';


InputDecoration authFieldDecor(String hintText) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
  );
}

InputDecoration profileFieldDecor(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
    ),
  );
}

InputDecoration genderFieldDecor(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
    ),
  );
}

InputDecoration locationFieldDecor(String hintText) {
  return InputDecoration(
    suffixIcon: const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(Icons.location_pin),
    ),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
    ),
  );
}
