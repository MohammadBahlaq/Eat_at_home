import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/view/verify_page.dart';
import 'package:eat_at_home/widgets/custom_textfield.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/user_controller.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  // void verifyOTP() {
  //   EmailAuth emailAuth = EmailAuth(sessionName: "Test Session");
  //   var res = emailAuth.validateOtp(
  //       recipientMail: "bahlaq57@gmail.com", userOtp: "767123");

  //   if (res) {
  //     print("verify OTP");
  //   } else {
  //     print("Not verify OTP");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final UserController userController = context.read<UserController>();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController txtName = TextEditingController();
    final TextEditingController txtEmail = TextEditingController();
    final TextEditingController txtPassword = TextEditingController();
    final TextEditingController txtPhone = TextEditingController();

    return ChangeNotifierProvider(
      create: (context) => Data(),
      builder: (context, child) {
        final Data dataController = context.read<Data>();
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
                  children: [
                    CustomTextFeild(
                      controller: txtName,
                      labelText: "Name",
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                      validator: (txt) {
                        return txt!.isNotEmpty &&
                                isAlpha(txt.replaceAll(" ", ""))
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
                    Selector<Data, bool>(
                      selector: (p0, p1) => p1.isVisiableSignup,
                      builder: (context, isVisiable, child) {
                        return CustomTextFeild(
                          controller: txtPassword,
                          labelText: "Password",
                          icon: Icons.password,
                          obscureText: isVisiable,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisiable
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              dataController.visibilityS();
                            },
                          ),
                          validator: (txt) {
                            return txt!.isNotEmpty && txt.length > 7
                                ? null
                                : "The password must be at least 8 character";
                          },
                        );
                      },
                    ),
                    CustomTextFeild(
                      controller: txtPhone,
                      labelText: "Mobile number",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (txt) {
                        return txt!.isNotEmpty &&
                                txt.length == 10 &&
                                isNumeric(txt)
                            ? null
                            : "Please write a valid phone number";
                      },
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: const Text("Next", style: TextStyle(fontSize: 18)),
                onClick: () async {
                  if (formKey.currentState!.validate()) {
                    userController.sendOTP(txtEmail.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Verify(
                          name: txtName.text,
                          email: txtEmail.text,
                          password: txtPassword.text,
                          phone: txtPhone.text,
                        ),
                      ),
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       content: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           const Text("Loading...",
                    //               style: TextStyle(fontSize: 18)),
                    //           SizedBox(
                    //               height:
                    //                   MediaQuery.of(context).size.height / 25),
                    //           const CircularProgressIndicator(),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                    // int msg = await userController.signupUser(
                    //   txtEmail.text,
                    //   txtPassword.text,
                    //   txtName.text,
                    //   txtPhone.text,
                    // );
                    // if (msg == 0) {
                    //   Navigator.of(context).pop();
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return CustomDialog(
                    //         onClick: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         title: "Exist",
                    //         msg: "This user is already exsit",
                    //       );
                    //     },
                    //   );
                    // } else {
                    //   Navigator.of(context)
                    //       .pushNamedAndRemoveUntil("login", (route) => false);
                    // }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
