import 'package:cancerconnector/pages/login.dart';
import 'package:cancerconnector/widgets/bottom_navigations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/styles.dart';
import '../widgets/custom_btn.dart';

class OnBoardingThree extends StatefulWidget {
  final void Function()? nextPage;
  final void Function()? prevPage;
  const OnBoardingThree(
      {super.key, required this.nextPage, required this.prevPage});

  @override
  State<OnBoardingThree> createState() => _OnBoardingThreeState();
}

class _OnBoardingThreeState extends State<OnBoardingThree> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/logo.png"),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Dare To Donate",
            style: appBigTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Arcu tristique tristique quam in.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyCustomBtn(
            onTap: () {
              Get.to(const LogInSignUp());
            },
            buttonText: "Register",
          ),
          const SizedBox(
            height: 10,
          ),
          MyCustomBtn(
            onTap: () {
              Get.to(const LogInSignUp());
            },
            buttonText: "Login",
          ),
          const SizedBox(
            height: 10,
          ),
          getBottomNavigations(
              nextPage: widget.nextPage, prevPage: widget.prevPage),
        ],
      ),
    );
  }
}
