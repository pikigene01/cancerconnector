import 'package:cancerconnector/pages/home_page.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset("assets/pana.png"),
          const SizedBox(
            height: 10,
          ),
          const Text("Help is successfully requested."),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(const HomePage());
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(50)),
              child: const Center(
                  child: FaIcon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
              )),
            ),
          ),
        ],
      )),
    );
  }
}
