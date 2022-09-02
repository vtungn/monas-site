import 'package:flutter/material.dart';

InputDecoration inputNumberBorder() {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.black),
    borderRadius: BorderRadius.circular(10.0),
  ));
}
