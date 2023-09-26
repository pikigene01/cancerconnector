import 'package:cancerconnector/themes/styles.dart';
import 'package:flutter/material.dart';

Widget getBottomNavigations(
    {required void Function()? nextPage, required void Function()? prevPage}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: prevPage,
          child: Text(
            "Prev",
            style: appBigTitle,
          ),
        ),
        InkWell(
          onTap: nextPage,
          child: Text(
            "Next",
            style: appBigTitle,
          ),
        ),
      ],
    ),
  );
}
