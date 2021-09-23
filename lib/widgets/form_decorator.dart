import 'package:flutter/material.dart';

InputDecoration formDecorator(String label) {
  return InputDecoration(
    hintStyle: TextStyle(color: Colors.white),
    border: new OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      borderSide: new BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        borderSide: BorderSide(color: Colors.white)),
    // hintText: 'Enter Title',
    labelText: label,
    isDense: true,
  );
}
