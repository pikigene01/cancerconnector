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
    return Container();
  }
}
