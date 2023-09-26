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
      ],
    ));
  }
}
