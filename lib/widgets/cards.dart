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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("34min ago"),
              Text(
                "Donate",
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
