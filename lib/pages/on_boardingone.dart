import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottom_navigations.dart';
import 'package:flutter/material.dart';

class OnBoardingOne extends StatefulWidget {
  final void Function()? nextPage;
  final void Function()? prevPage;
  const OnBoardingOne(
      {super.key, required this.nextPage, required this.prevPage});

  @override
  State<OnBoardingOne> createState() => _OnBoardingOneState();
}

class _OnBoardingOneState extends State<OnBoardingOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/bro.png"),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Find Doctors",
            style: appBigTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "We have specialists which helps patients in all sort of problems they might face.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          getBottomNavigations(
              nextPage: widget.nextPage, prevPage: widget.prevPage),
        ],
      ),
    );
  }
}
