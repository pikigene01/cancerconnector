import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/my_text_fields.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var searchController = TextEditingController();
    return Scaffold(
      body: getBody(size: size, searchController: searchController),
      bottomNavigationBar: const BottomBar(index: 0),
    );
  }

  Widget getBody({required size, required searchController}) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            topBar(pageTitle: "Report", size: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/map-pin.png",
                  width: 40,
                ),
                const Text("Research Center")
              ],
            ),
            Image.asset("assets/Group 44.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.grey.shade400,
                    filled: true,
                    hintText: "Add your report",
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            MyCustomBtn(onTap: () {}, buttonText: "Send Report"),
          ],
        ),
      ),
    );
  }
}
