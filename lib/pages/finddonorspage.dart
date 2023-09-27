import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class FindDonorsPage extends StatefulWidget {
  const FindDonorsPage({super.key});

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(size: size),
      bottomNavigationBar: const BottomBar(index: 1),
    );
  }

  Widget getBody({required size}) {
    return SafeArea(
        child: Column(
      children: [
        topBar(pageTitle: "Find Doctors", size: size),
      ],
    ));
  }
}
