import 'package:flutter/material.dart';

TextStyle textStyle(
        {FontWeight? fontWeight, double? fontSize, Color? textColor}) =>
    TextStyle(
        fontFamily: 'SFPro',
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: textColor ?? Colors.black);
