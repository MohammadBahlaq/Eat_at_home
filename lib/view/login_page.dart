// ignore_for_file: use_build_context_synchronously

import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/controller/product_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/custom_dialog.dart';
import 'package:eat_at_home/widgets/custom_textfield.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/cart_controller.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    final UserController userController = context.read<UserController>();
    final ProductController productCrt = context.read<ProductController>();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController txtEmail = TextEditingController();
    final TextEditingController txtPassword = TextEditingController();

    return ChangeNotifierProvider(
      create: (context) => Data(),
      builder: (context, child) {
        final Data dataController = context.read<Data>();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: ListView(
            padding: const EdgeInsets.only(top: 20),
            children: [
              CircleAvatar(
                radius: 125,
                child: Image.asset(
                  "images/logo.png",
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
                    Selector<Data, bool>(
                      selector: (p0, p1) => p1.isVisiable,
                      builder: (context, isVisiable, child) {
                        return CustomTextFeild(
                          controller: txtPassword,
                          labelText: "Password",
                          icon: Icons.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isVisiable,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisiable
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              dataController.visibility();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Selector<Data, bool>(
                    selector: (p0, p1) => p1.remember,
                    builder: (context, remember, child) => Checkbox(
                      value: remember,
                      onChanged: (value) {
                        dataController.setRemember();
                      },
                    ),
                  ),
                  const Text("Remember me", style: TextStyle(fontSize: 15)),
                ],
              ),
              CustomButton(
                text: const Text("Login", style: TextStyle(fontSize: 18)),
                onClick: () async {
                  var nav = Navigator.of(context);

                  if (formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    final int msg = await userController.login(
                      txtEmail.text,
                      txtPassword.text,
                    );

                    if (msg == 1) {
                      //userController.setLogin = true;
                      cartController.getCart(userController.userInfo!.id);
                      productCrt.getProduct("Pizza");
                      nav.pushNamedAndRemoveUntil("home", (route) => false);
                      if (dataController.remember) {
                        dataController.checkRemember(txtEmail.text,
                            txtPassword.text, userController.userInfo!.id);
                      }
                    } else {
                      nav.pop();
                      showErrorAlertDialog(context);
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
                    child: Text(
                      "Signup",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
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
      },
    );
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Loading...", style: TextStyle(fontSize: 18)),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  showErrorAlertDialog(BuildContext context) {
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
