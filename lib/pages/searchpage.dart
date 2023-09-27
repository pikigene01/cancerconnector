import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/cards.dart';
import 'package:cancerconnector/widgets/getSearch.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var inputTextController = TextEditingController();
  var searchController = TextEditingController();
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
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          topBar(pageTitle: "Search", size: size),
          const SizedBox(
            height: 20,
          ),
          getSearchBarSearch(
              size: size, searchController: searchController, onTap: () {}),
          requestCard(size: size),
          const SizedBox(
            height: 10,
          ),
          requestCard(size: size),
          const SizedBox(
            height: 10,
          ),
          requestCard(size: size),
          const SizedBox(
            height: 10,
          ),
          requestCard(size: size),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
