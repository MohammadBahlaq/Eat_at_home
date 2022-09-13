import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/view/bill_detailes.dart';
import 'package:eat_at_home/view/bill_page.dart';
import 'package:eat_at_home/view/cart_page.dart';
import 'package:eat_at_home/view/home_page.dart';
import 'package:eat_at_home/view/login_page.dart';
import 'package:eat_at_home/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
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
        ChangeNotifierProvider(create: (context) => BillController())
      ],
      builder: (context, child) {
        if (prefs!.getString("email") != null) {
          context
              .read<UserController>()
              .login(prefs!.getString("email")!, prefs!.getString("password")!);
        }
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.blueAccent,
            inputDecorationTheme: const InputDecorationTheme(),
            listTileTheme: ListTileThemeData(
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: const Home(),
          routes: {
            "cart": (context) => const Cart(),
            "signup": (context) => const Signup(),
            "login": (context) => const Login(),
            "home": (context) => const Home(),
            "bill": (context) => const Bill(),
            "detailes": (context) => const BillDetailes(),
          },
        );
      },
    );
  }
}
