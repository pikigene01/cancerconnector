import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/themes/app_strings.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:flutter/material.dart';

import '../widgets/bottombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  bool isSearching = false;

  String? addressFromLocation = "";
  String? longitude = "";
  String? latitude = "";
  String? country = "";
  bool locating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: const BottomBar(
        index: 0,
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/Group 17.png",
                  width: 20,
                ),
                Image.asset(
                  "assets/Vector.png",
                  width: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width,
              height: 200,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primaryColor, appTextColor]),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 10,
                        color: appTextColor)
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bannerTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            startNowText,
                            style: appStyleText,
                          ),
                          const Icon(Icons.access_alarm)
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                customMenus(
                    size: size,
                    title: "Gene Piki",
                    imgPath: "assets/ion_search-outline.png"),
                customMenus(
                    size: size,
                    title: "Gene Piki",
                    imgPath: "assets/ion_search-outline.png"),
                customMenus(
                    size: size,
                    title: "Gene Piki",
                    imgPath: "assets/ion_search-outline.png"),
              ],
            ),
          )
        ],
      ),
    );
  }

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
            Image.asset(imgPath),
            Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
