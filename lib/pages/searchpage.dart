import 'package:cancerconnector/themes/styles.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/cards.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var inputTextController = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: size.width / 1.2,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    controller: inputTextController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black),
                      prefixStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Container(
                    decoration: const BoxDecoration(color: primaryColor),
                    child: Image.asset("assets/Group 25.png"),
                  ),
                ),
              ],
            ),
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
          requestCard(size: size),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
