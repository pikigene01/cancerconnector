import 'package:cancerconnector/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../themes/styles.dart';
import '../widgets/custom_btn.dart';
import '../widgets/my_text_fields.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var emailTextController = TextEditingController();
  bool loading = false;

  void sendResetLink() async {
    setState(() {
      loading = true;
    });
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      authService.resetUserPassword(emailTextController.text);
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
              MyTextFieldWidget(
                controller: emailTextController,
                hintText: "Please Enter Your Email",
                obscureText: false,
                isBigInput: false,
              ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? MyCustomBtn(
                      buttonText: 'Loading please wait..',
                      onTap: () {},
                    )
                  : MyCustomBtn(
                      buttonText: 'Send Reset Link',
                      onTap: () {
                        sendResetLink();
                      },
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Do not have account?'),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      ' Register',
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
