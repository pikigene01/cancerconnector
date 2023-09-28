import 'package:flutter/material.dart';

import '../themes/styles.dart';

Widget requestCard({required size}) {
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
          Text(
            "Name",
            style: appBigTitle,
          ),
          const Text("Gene Piki"),
          Text(
            "Location",
            style: appBigTitle,
          ),
          const Text("Harare, Zimbabwe"),
          Text(
            "Description",
            style: appBigTitle,
          ),
          const Text("l faced issue on"),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("34min ago"),
              Text(
                "Offer Help",
                style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    ),
  );
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
                Image.asset(
                  doctor!['image'].toString(),
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Text(doctor!['name'].toString()),
                    Text(doctor!['location'].toString()),
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
