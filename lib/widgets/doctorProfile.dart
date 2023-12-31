import 'package:cancerconnector/pages/chat_view.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getDoctorProfile({required doctor, required size}) {
  return SizedBox(
    width: size.width,
    child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              backgroundImage: NetworkImage(doctor!["imageUrl"].toString()),
            )),
        Text(
          doctor["name"],
          style: appBigTitle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/map-pin.png",
              height: 30,
            ),
            Text(doctor!["location"].toString()),
          ],
        ),
        Text(doctor!["description"].toString()),
        MyCustomBtn(
            onTap: () {
              Get.to(() => ChatViewPage(
                  receiverEmail: doctor!["email"].toString(),
                  receiverUserId: doctor!["user_id"].toString()));
            },
            buttonText: "Get Help"),
      ],
    ),
  );
}
