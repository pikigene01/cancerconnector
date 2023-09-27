import 'package:flutter/material.dart';

Widget customMenus(
    {required size, required String title, required String imgPath}) {
  return Container(
    width: size.width / 3,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(5, 5),
              color: Colors.black.withOpacity(0.1)),
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(-5, -5),
              color: Colors.grey.withOpacity(0.1))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: 40,
          ),
          FittedBox(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
