import 'package:cancerconnector/pages/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/styles.dart';

Widget requestCard({required size, required doc, required search}) {
  if (doc['name'].toString().toLowerCase().contains(search.toString().toLowerCase()) ||
      doc['location'].toString().toString().contains(search.toString().toLowerCase())) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 20,
                offset: const Offset(5, 10),
                color: Colors.black.withOpacity(0.1))
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: appBigTitle,
                ),
                Text(doc!["name"].toString()),
                Text(
                  "Location",
                  style: appBigTitle,
                ),
                Text(doc!["location"].toString()),
                Text(
                  "Description",
                  style: appBigTitle,
                ),
                Text(doc!["description"].toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateTime.parse(doc!["timestamp"].toDate().toString())
                        .toString()),
                    InkWell(
                      onTap: () {
                        Get.to(ChatViewPage(
                            receiverEmail: doc!["email"].toString(),
                            receiverUserId: doc!["email"].toString()));
                      },
                      child: const Text(
                        "Offer Help",
                        style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  } else {
    return Container();
  }
}

Widget doctorsCard(
    {required size,
    required doctor,
    required String search,
    required void Function()? onTap}) {
  if (doctor['name'].toString().contains(search) ||
      doctor['location'].toString().contains(search)) {
    return Container(
      width: size.width - 10,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 20,
            offset: const Offset(5, 10),
            color: Colors.black.withOpacity(0.1))
      ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor,
                  backgroundImage: NetworkImage(doctor!["imageUrl"].toString()),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor!['name'].toString()),
                    Text(doctor!['location'].toString().substring(0, 30)),
                  ],
                ),
                InkWell(
                  onTap: onTap,
                  child: const Text(
                    "View",
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}
