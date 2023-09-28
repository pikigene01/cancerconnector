import 'package:cancerconnector/pages/successpage.dart';
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/my_text_fields.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/create_request_service.dart';
import '../services/geo_locator_service.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  var addressController = TextEditingController();
  var problemDescriptionController = TextEditingController();
  final geoloocationService = GeoLocationService();
  final _requestService = CreateRequestService();
  String? longitude;
  String? latitude;

  bool loading = false;
  void createRequest() async {
    setState(() {
      loading = true;
    });

    var geolocationResults = await geoloocationService.getLocationCoordinates();
    if (geolocationResults!['error'] == true) {
      var msg = geolocationResults['msg'] ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg.toString()),
        ),
      );
    }
    setState(() {
      longitude = geolocationResults!['longitude'].toString();
      latitude = geolocationResults!['latitude'].toString();
      addressController.text = geolocationResults!['address'].toString();
    });

    if (problemDescriptionController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please fill all fields',
        ),
      ));
      setState(() {
        loading = false;
      });
      return;
    }
    var result = await _requestService.saveRequest(
      name: "Gene Piki",
      location: addressController.text,
      description: problemDescriptionController.text,
      longitude: geolocationResults!['longitude'].toString(),
      latitude: geolocationResults!['latitude'].toString(),
    );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Your Item Created Successfully...',
      ),
    ));
    setState(() {
      loading = false;
    });
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
          loading
              ? MyCustomBtn(onTap: () {}, buttonText: "Creating Please Wait")
              : MyCustomBtn(
                  onTap: createRequest, buttonText: "Create Your Request"),
        ],
      )),
    );
  }
}
