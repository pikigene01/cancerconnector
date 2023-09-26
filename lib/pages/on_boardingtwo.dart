import 'package:cancerconnector/widgets/bottom_navigations.dart';
import 'package:flutter/material.dart';

import '../themes/styles.dart';

class OnBoardingTwo extends StatefulWidget {
  final void Function()? nextPage;
  final void Function()? prevPage;
  const OnBoardingTwo(
      {super.key, required this.nextPage, required this.prevPage});

  @override
  State<OnBoardingTwo> createState() => _OnBoardingTwoState();
}

class _OnBoardingTwoState extends State<OnBoardingTwo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/rafiki.png"),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Help Others Who Get Affected",
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
          getBottomNavigations(
              nextPage: widget.nextPage, prevPage: widget.prevPage),
        ],
      ),
    );
  }
}
