import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(index: 4),
      body: getBody(size: size),
    );
  }

  Widget getBody({required size}) {
    return SafeArea(
        child: Column(
      children: [
        topBar(pageTitle: "Your Profile", size: size),
        Image.asset(
          doctors[1]["image"].toString(),
          height: 70,
        ),
        const SizedBox(
          height: 60,
        ),
        Text(
          doctors[1]["name"],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/map-pin.png",
              height: 30,
            ),
            Text(doctors[1]!["location"].toString()),
          ],
        ),
      ],
    ));
  }
}
