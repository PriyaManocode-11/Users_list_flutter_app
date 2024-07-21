import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle textStyle(
        {FontWeight? fontWeight, double? fontSize, Color? textColor}) =>
    TextStyle(
        fontFamily: 'SFPro',
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: textColor ??
            (Platform.isIOS ? CupertinoColors.black : Colors.black));
