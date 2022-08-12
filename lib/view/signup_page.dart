// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:e_commerce/widgets/custom_dialog.dart';
import 'package:e_commerce/widgets/custom_textfield.dart';
import 'package:e_commerce/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/user_controller.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shignup")),
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
                  controller: txtName,
                  labelText: "Name",
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  validator: (txt) {
                    return txt!.isNotEmpty && isAlpha(txt)
                        ? null
                        : "Please the name must have just alpha";
                  },
                ),
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
                  validator: (txt) {
                    return txt!.isNotEmpty && txt.length > 7
                        ? null
                        : "The password must be at least 8 character";
                  },
                ),
                CustomTextFeild(
                  controller: txtPhone,
                  labelText: "Mobil number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (txt) {
                    return txt!.isNotEmpty && txt.length == 10 && isNumeric(txt)
                        ? null
                        : "Please write a valid phone number";
                  },
                ),
              ],
            ),
          ),
          CustomButton(
            text: const Text("Signup", style: TextStyle(fontSize: 18)),
            onClick: () async {
              if (formKey.currentState!.validate()) {
                int msg = await context.read<UserController>().signupUser(
                      txtEmail.text,
                      txtPassword.text,
                      txtName.text,
                      txtPhone.text,
                    );
                if (msg == 0) {
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
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
