import 'package:flutter/material.dart';
import 'package:pomodolo/shared/constant.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

const textInputDecoration = InputDecoration(
  labelStyle:
      TextStyle(color: Constant.whiteColor, fontWeight: FontWeight.w300),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
);
