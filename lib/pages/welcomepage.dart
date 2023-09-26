import 'package:cancerconnector/pages/on_boardingone.dart';
import 'package:cancerconnector/pages/on_boardingthree.dart';
import 'package:cancerconnector/pages/on_boardingtwo.dart';
import 'package:flutter/material.dart';

class WelocomePage extends StatefulWidget {
  const WelocomePage({super.key});

  @override
  State<WelocomePage> createState() => _WelocomePageState();
}

class _WelocomePageState extends State<WelocomePage> {
  int currentBoard = 1;
  nextPage() {
    if (currentBoard >= 3) return;
    setState(() {
      currentBoard = ++currentBoard;
    });
  }

  prevPage() {
    if (currentBoard <= 1) return;
    setState(() {
      currentBoard = --currentBoard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        currentBoard == 1
            ? OnBoardingOne(
                prevPage: () {
                  prevPage();
                },
                nextPage: () {
                  nextPage();
                },
              )
            : const SizedBox(),
        currentBoard == 2
            ? OnBoardingTwo(
                prevPage: () {
                  prevPage();
                },
                nextPage: () {
                  nextPage();
                },
              )
            : const SizedBox(),
        currentBoard == 3
            ? OnBoardingThree(
                prevPage: () {
                  prevPage();
                },
                nextPage: () {
                  nextPage();
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
