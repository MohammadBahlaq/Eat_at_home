import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/view/bill_page.dart';
import 'package:eat_at_home/view/cart_page.dart';
import 'package:eat_at_home/view/home_page.dart';
import 'package:eat_at_home/view/login_page.dart';
import 'package:eat_at_home/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor primaryAppColor = Colors.lightBlue;
    //const Color appColor = Colors.red;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => BillController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryAppColor,
          inputDecorationTheme: const InputDecorationTheme(
              //iconColor: appColor,
              // focusColor: appColor,
              // hoverColor: appColor,
              ),
          // iconTheme: const IconThemeData(color: appColor),
          // primaryIconTheme: const IconThemeData(color: appColor),
          // accentIconTheme: const IconThemeData(color: appColor),
          // buttonTheme: ButtonThemeData(buttonColor: Colors.red),
        ),
        home: const Home(),
        routes: {
          "cart": (context) => const Cart(),
          "signup": (context) => Signup(),
          "login": (context) => Login(),
          "home": (context) => const Home(),
          "bill": (context) => const Bill(),
        },
      ),
    );
  }
}
