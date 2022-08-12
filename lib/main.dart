import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/data.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:e_commerce/view/cart_page.dart';
import 'package:e_commerce/view/home_page.dart';
import 'package:e_commerce/view/login_page.dart';
import 'package:e_commerce/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => UserController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
        routes: {
          "cart": (context) => const Cart(),
          "signup": (context) => Signup(),
          "login": (context) => Login(),
          "home": (context) => const Home(),
        },
      ),
    );
  }
}
