// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:e_commerce/controller/data.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:e_commerce/widgets/custom_textfield.dart';
import 'package:e_commerce/widgets/login_signup_btn.dart';
import 'package:e_commerce/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import '../controller/cart_controller.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 125,
            child: Image.asset(
              "images/logo.png",
              //height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFeild(
                  controller: txtEmail,
                  labelText: "Email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (txt) {
                    return txt!.isNotEmpty && isEmail(txt)
                        ? null
                        : "Please write a valid Email";
                  },
                ),
                CustomTextFeild(
                  controller: txtPassword,
                  labelText: "Password",
                  icon: Icons.password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ],
            ),
          ),
          CustomButton(
            text: const Text("Login", style: TextStyle(fontSize: 18)),
            onClick: () async {
              if (formKey.currentState!.validate()) {
                int msg = await context.read<UserController>().login(
                      txtEmail.text,
                      txtPassword.text,
                    );

                if (msg == 1) {
                  context.read<UserController>().setLogin = true;
                  await context
                      .read<CartController>()
                      .getCart(context.read<UserController>().userInfo!.id);
                  print(
                      "Total Price: ${context.read<CartController>().totalPrice}");
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("home", (route) => false);
                } else {
                  showDialog(
                    context: context,
                    builder: ((context) => CustomDialog(
                          title: "Ivalid Login",
                          msg: "User name or Password is not correct",
                          onClick: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  );
                }
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You don't have account? ",
                style: TextStyle(fontSize: 17),
              ),
              InkWell(
                child: const Text(
                  "Signup",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("signup");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
