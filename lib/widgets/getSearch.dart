import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/styles.dart';

Widget getSearchBarSearch(
    {required size,
    required searchController,
    required void Function()? onTap}) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 15),
        height: 55,
        width: size.width - 40,
        decoration: BoxDecoration(
          color: appTextColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 40,
                      width: size.width - 90, // set desired height here
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          prefixIcon: FaIcon(FontAwesomeIcons.file),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          border: InputBorder.none,
                          labelText: 'Type here to search',
                          focusColor: Colors.black12,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onTap,
                    child: const FaIcon(FontAwesomeIcons.search),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(5),
            //   child: Container(
            //     height: 35,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: const Padding(
            //       padding: EdgeInsets.only(left: 15, right: 15),
            //       child: Row(
            //         children: [
            //           FaIcon(FontAwesomeIcons.search),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           SizedBox(width: 2),
            //           FaIcon(FontAwesomeIcons.arrowDown),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ],
  );
}
