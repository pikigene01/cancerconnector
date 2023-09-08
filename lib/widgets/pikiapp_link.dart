import 'package:flutter/material.dart';

import '../themes/styles.dart';

Widget pikiappLink(
    {required String text,
    required double width,
    alignment = CrossAxisAlignment.center,
    style = const TextStyle(
        color: primaryColor, fontSize: 25, fontWeight: FontWeight.w500)}) {
  return SizedBox(
    width: width,
    // height: 50,
    child: Column(crossAxisAlignment: alignment, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style,
        ),
      ),
      const Divider(
        color: Colors.black,
        height: 10,
      ),
    ]),
  );
}
