import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/pages/finddonorspage.dart';
import 'package:cancerconnector/pages/reportpage.dart';
import 'package:cancerconnector/pages/searchpage.dart';
import 'package:cancerconnector/services/auth_service.dart';
import 'package:cancerconnector/themes/app_strings.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/cards.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../services/create_request_service.dart';
import '../widgets/bottombar.dart';
import '../widgets/custom_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  bool isSearching = false;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final _requestService = CreateRequestService();

  String? addressFromLocation = "";
  String? longitude = "";
  String? latitude = "";
  String? country = "";
  bool locating = false;
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(),
      key: _globalKey,
      bottomNavigationBar: const BottomBar(
        index: 0,
      ),
      drawer: getDrawer(size: size),
    );
  }

  Widget getDrawer({required size}) {
    return SafeArea(
      child: Drawer(
        width: size.width / 2,
        backgroundColor: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                appName,
                style: appStyleText,
              ),
              const Divider(
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "App By: PikiDelivery",
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "Phone: 0782954717",
                style: TextStyle(color: Colors.white),
              ),
              MyCustomBtn(
                onTap: () async {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);
                  authService.signOut();
                },
                buttonText: "Logout",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _globalKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      "assets/Group 17.png",
                      width: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                    child: Image.asset(
                      "assets/Vector.png",
                      width: 20,
                    ),
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
                            const Icon(
                              Icons.access_alarm,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const SearchPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Offer Help",
                          imgPath: "assets/ion_search-outline.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const SearchPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Donates",
                          imgPath: "assets/openmoji_blood-transfusion.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const FindDonorsPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Order Bloods",
                          imgPath: "assets/si-glyph_blood-bag.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const FindDonorsPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Assistant",
                          imgPath: "assets/maki_doctor-11.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const ReportPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Report",
                          imgPath: "assets/la_file-medical-alt.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const SearchPage());
                      },
                      child: customMenus(
                          size: size,
                          title: "Campaign",
                          imgPath: "assets/grommet-icons_announce.png"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Help Requests",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            _buildeRequestCards(size: size),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildeRequestCards({required size}) {
    return StreamBuilder(
      stream: _requestService.getRequests(latitude: "", longitude: ""),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error Whilst loading");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading please wait..');
        }
        return Column(
          children: snapshot.data!.docs
              .map((document) =>
                  requestCard(size: size, doc: document, search: searchValue))
              .toList(),
        );
      },
    );
  }
}
