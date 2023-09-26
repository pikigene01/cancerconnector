import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(
        index: 1,
      ),
      body: getBody(size: size),
    );
  }

  Widget getBody({required size}) {
    return SafeArea(
        child: Column(
      children: [topBar(pageTitle: "Search", size: size)],
    ));
  }
}
