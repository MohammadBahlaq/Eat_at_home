// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  static String apiPath =
      "https://mohammadbahlaq.000webhostapp.com/api/"; //http://10.0.2.2/EatAtHome/api/
  static String imgPath =
      "https://mohammadbahlaq.000webhostapp.com/images/"; //http://10.0.2.2/EatAtHome/images/

  bool isVisiable = true;

  void visibility() {
    isVisiable = !isVisiable;
    notifyListeners();
  }
}
