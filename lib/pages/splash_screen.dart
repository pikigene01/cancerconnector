import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: getBody(),
      bottomNavigationBar: const BottomBar(index: 1),
    );
  }

  Widget getBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/blood.jpg',
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Dare To Donate',
            style: appStyleText,
          )
        ],
      ),
    );
  }
}
