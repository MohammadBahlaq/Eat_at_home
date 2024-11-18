// ignore_for_file: use_build_context_synchronously

import 'package:eat_at_home/widgets/custom_dialog.dart';
import 'package:eat_at_home/widgets/custom_textfield.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/user_controller.dart';

class Verify extends StatelessWidget {
  const Verify({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final UserController userController = context.read<UserController>();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController ctrOTP = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: "We have sent the verification code to the ",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        TextSpan(
                          text: email,
                          style: TextStyle(decoration: TextDecoration.none, fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTextFeild(
                  controller: ctrOTP,
                  labelText: "Enter verification code",
                  icon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  validator: (txt) {
                    return txt!.isNotEmpty && isNumeric(txt) ? null : "Please the verification code must have just numbers";
                  },
                ),
              ],
            ),
          ),
          CustomButton(
            text: const Text("Signup", style: TextStyle(fontSize: 18)),
            onClick: () async {
              if (formKey.currentState!.validate()) {
                if (userController.verifyOTP(email, ctrOTP.text)) {
                  loadingDialog(context);

                  int msg = await userController.signupUser(email, password, name, phone);

                  if (msg == 0) {
                    Navigator.of(context).pop();
                    existDialog(context);
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void loadingDialog(BuildContext context) {
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

  void existDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          onClick: () {
            Navigator.of(context).pop();
          },
          title: "Exist",
          msg: "This user is already exsit",
        );
      },
    );
  }
}
