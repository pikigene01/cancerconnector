import 'package:cancerconnector/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../themes/styles.dart';
import '../widgets/custom_btn.dart';
import '../widgets/my_text_fields.dart';

class LogInSignUp extends StatefulWidget {
  const LogInSignUp({super.key});

  @override
  State<LogInSignUp> createState() => _LogInSignUpState();
}

class _LogInSignUpState extends State<LogInSignUp> {
  var emailTextController = TextEditingController();
  var fullNameTextController = TextEditingController();
  bool isDoctor = false;
  var passwordTextController = TextEditingController();
  var confirmTextController = TextEditingController();
  bool toggleLogin = false;
  bool loading = false;

  void signIn() async {
    setState(() {
      loading = true;
    });
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailTextController.text, passwordTextController.text);
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  void signUp() async {
    setState(() {
      loading = true;
    });
    if (passwordTextController.text != confirmTextController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password do not match!"),
        ),
      );
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(emailTextController.text,
          passwordTextController.text, fullNameTextController.text, isDoctor);
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/logo new.png",
                width: 60,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Welcome to our app',
                style: appStyleText,
              ),
              const SizedBox(
                height: 10,
              ),
              toggleLogin
                  ? MyTextFieldWidget(
                      controller: fullNameTextController,
                      hintText: "Please Enter Your Full Name",
                      obscureText: false,
                      isBigInput: false,
                    )
                  : Container(),
              toggleLogin
                  ? Row(
                      children: [
                        const Text("Are you a doctor?"),
                        Checkbox(
                            value: isDoctor,
                            onChanged: (data) {
                              setState(() {
                                isDoctor = !isDoctor;
                              });
                            }),
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              MyTextFieldWidget(
                controller: emailTextController,
                hintText: "Please Enter Your Email",
                obscureText: false,
                isBigInput: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFieldWidget(
                controller: passwordTextController,
                hintText: "Please Enter Your Password",
                obscureText: true,
                isBigInput: false,
              ),
              const SizedBox(
                height: 10,
              ),
              toggleLogin
                  ? MyTextFieldWidget(
                      controller: confirmTextController,
                      hintText: "Please Enter Your Confirm Password",
                      obscureText: true,
                      isBigInput: false,
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              toggleLogin
                  ? loading
                      ? MyCustomBtn(
                          buttonText: 'Loading please wait..',
                          onTap: () {},
                        )
                      : MyCustomBtn(
                          buttonText: 'Register',
                          onTap: () {
                            signUp();
                          },
                        )
                  : !loading
                      ? MyCustomBtn(
                          buttonText: 'Login',
                          onTap: () {
                            signIn();
                          },
                        )
                      : MyCustomBtn(
                          buttonText: 'Loading please wait..',
                          onTap: () {},
                        ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(const ResetPasswordPage());
                      },
                      child: const Text(
                        'Forgot your password',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Do not have account?'),
                  InkWell(
                    onTap: () {
                      setState(() {
                        toggleLogin = !toggleLogin;
                      });
                    },
                    child: Text(
                      !toggleLogin ? ' Register' : ' Login',
                      style: textWithUnderline,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        )),
      ),
    );
  }
}
