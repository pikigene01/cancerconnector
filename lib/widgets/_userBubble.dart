import 'package:flutter/material.dart';

Widget userBubble({required String name, required size}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: size.width,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(name),
        ),
      ),
      const SizedBox(
        height: 8,
      )
    ],
  );
}
