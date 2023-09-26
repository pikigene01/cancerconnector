import 'package:cancerconnector/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget topBar({required String pageTitle, required size}) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset(
          "assets/Back Arrow.png",
          width: 60,
        ),
      ),
      SizedBox(
        width: size.width / 4,
      ),
      Text(
        pageTitle,
        style: appBigTitle,
      ),
    ],
  );
}
