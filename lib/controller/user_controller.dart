// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserController with ChangeNotifier {
  User? userInfo;
  bool isLogin = false;

  set setLogin(isLogin) {
    this.isLogin = isLogin;
    notifyListeners();
  }

  Future<int> signupUser(
      String email, String password, String name, String phone) async {
    String url = "${Data.apiPath}signup.php";

    var response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      },
    );
    int responsebody = int.parse(response.body.toString());

    return responsebody;
  }

  Future<int> login(String email, String password) async {
    String url = "${Data.apiPath}login.php";

    var response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "password": password,
      },
    );

    var userData = jsonDecode(response.body);

    if (userData != 0) {
      print(userData);
      userInfo = User(
        id: userData['user_id'],
        email: userData['email'],
        password: userData['password'],
        name: userData['name'],
        mobile: userData['mobile'],
      );
      setLogin = true;
      return 1;
    } else {
      return 0;
    }
  }
}
