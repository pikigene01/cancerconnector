import 'package:cancerconnector/pages/successpage.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/my_text_fields.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  var addressController = TextEditingController();
  var problemDescriptionController = TextEditingController();
  void createRequest() {
    print("creating new request");
    Get.to(const SuccessPage());
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
                controller: addressController,
                hintText: "Enter Your Address",
                obscureText: false,
                isBigInput: false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
                controller: problemDescriptionController,
                hintText: "Describe your problem",
                obscureText: false,
                isBigInput: true),
          ),
          MyCustomBtn(onTap: createRequest, buttonText: "Create Your Request"),
        ],
      )),
    );
  }
}
