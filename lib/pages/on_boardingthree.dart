import 'package:cancerconnector/widgets/bottom_navigations.dart';
import 'package:flutter/material.dart';

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
          getBottomNavigations(
              nextPage: widget.nextPage, prevPage: widget.prevPage),
        ],
      ),
    );
  }
}
