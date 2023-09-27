import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(size: size),
      bottomNavigationBar: const BottomBar(index: 2),
    );
  }

  Widget getBody({required size}) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          topBar(pageTitle: "Help Request", size: size),
          const SizedBox(
            height: 10,
          ),
          MyCustomBtn(onTap: () {}, buttonText: "Create Your Request"),
        ],
      )),
    );
  }
}
