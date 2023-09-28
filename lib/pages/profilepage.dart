import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/services/create_request_service.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/my_text_fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var fullNameTextController = TextEditingController();
  var _requestService = CreateRequestService();
  bool isDoctor = false;
  var userProfile = [];
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
    return SingleChildScrollView(
      child: SafeArea(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Full Name",
              obscureText: false,
              isBigInput: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text("Are you a doctor?"),
                Checkbox(
                    value: isDoctor,
                    onChanged: (data) {
                      setState(() {
                        isDoctor = !isDoctor;
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Location",
              obscureText: false,
              isBigInput: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Bio",
              obscureText: false,
              isBigInput: true,
            ),
          ),
          buildProfile(),
          MyCustomBtn(onTap: () {}, buttonText: "Update Profile"),
        ],
      )),
    );
  }

  Widget buildProfile() {
    return StreamBuilder(
        stream: _requestService.getYourProfile(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Text("Error");
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Text("Loading please wait");
          }
          return Text(snapshots.data!.docs[0]["full_name"].toString());
        });
  }
}
