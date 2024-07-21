import 'dart:io';

import 'package:flutter/cupertino.dart';

class ColorCode {
  static Color kPurple = Platform.isIOS
      ? CupertinoColors.systemPurple
      : const Color.fromARGB(255, 147, 110, 212);
}
