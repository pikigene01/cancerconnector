import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/cards.dart';
import 'package:cancerconnector/widgets/getSearch.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

import '../widgets/doctorProfile.dart';

class FindDonorsPage extends StatefulWidget {
  const FindDonorsPage({super.key});

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  var searchController = TextEditingController();
  String searchValue = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(size: size),
      bottomNavigationBar: const BottomBar(index: 1),
    );
  }

  Widget getBody({required size}) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          topBar(pageTitle: "Find Doctors", size: size),
          getSearchBarSearch(
              size: size,
              searchController: searchController,
              onTap: () {
                setState(() {
                  searchValue = searchController.text;
                });
              }),
          Column(
            children: doctors.reversed
                .map((doctor) => doctorsCard(
                    size: size,
                    doctor: doctor,
                    search: searchValue.toString(),
                    onTap: () {
                      doctorProfile(doctor: doctor);
                    }))
                .toList(),
          ),
        ],
      )),
    );
  }

  void doctorProfile({required doctor}) {
    showModalBottomSheet(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.9)),
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            getDoctorProfile(doctor: doctor, size: MediaQuery.of(context).size),
        // builder: (context) => MyProfile(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ));
  }
}
