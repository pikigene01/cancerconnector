import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pikideliveryapp/pages/home_page.dart';

import '../services/calculate_distance.dart';
import '../services/geo_locator_service.dart';
import '../services/product_service.dart';
import 'app_fitted_text.dart';
import 'my_custom_button.dart';
import 'my_text_field.dart';

class RequestDeliveryWidget extends StatefulWidget {
  final product;
  const RequestDeliveryWidget({super.key, required this.product});

  @override
  State<RequestDeliveryWidget> createState() => _RequestDeliveryWidgetState();
}

class _RequestDeliveryWidgetState extends State<RequestDeliveryWidget> {
  final _productService = ProductService();

  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productLocationController =
      TextEditingController();
  final TextEditingController _productStatusController =
      TextEditingController();
  final geoloocationService = GeoLocationService();
  String? longitude;
  String? latitude;
  String? addressFromLocation = "";
  String? price;
  String? img1 = "";
  String? productName = "";
  String? ownerEmail = "";
  String? distance = "";

  bool uploading = false;
  upDatePrice() async {
    int deliveryPrice;
    deliveryPrice = (int.parse(widget.product['price']) / 4).round();
    int createdPrice = int.parse(widget.product['price']) + deliveryPrice;
    setState(() {
      price = createdPrice.toString();
    });
    var geolocationResults = await geoloocationService.getLocationCoordinates();
    if (geolocationResults!['error'] == true) {
      var msg = geolocationResults['msg'] ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg.toString()),
        ),
      );
    } else {
      setState(() {
        price = createdPrice.toString();
        img1 = widget.product['img1'].toString();
        longitude = geolocationResults!['longitude'].toString();
        latitude = geolocationResults!['latitude'].toString();
      });
      if (latitude.toString() == 'null' ||
          longitude.toString() == 'null' ||
          longitude.toString().isEmpty ||
          latitude.toString().isEmpty ||
          widget.product['latitude'].toString() == 'null' ||
          widget.product['latitude'].toString().isEmpty ||
          widget.product['longitude'].toString().isEmpty ||
          widget.product['longitude'].toString() == 'null') return;
      var returnedDistance = calculateDistance(
          double.parse(latitude.toString()),
          double.parse(longitude.toString()),
          double.parse(widget.product['latitude'].toString()),
          double.parse(widget.product['longitude'].toString()));
      if (returnedDistance.toString().length > 4) {
        setState(() {
          distance = returnedDistance.toString();
        });
      }
    }
  }

  void createYourProductRequest() async {
    setState(() {
      uploading = true;
    });
    int createdPrice;
    int deliveryPrice;
    deliveryPrice = (int.parse(widget.product['price']) / 4).round();
    createdPrice = int.parse(widget.product['price']) + deliveryPrice;

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
      addressFromLocation = geolocationResults!['address'].toString();
      _productLocationController.text =
          geolocationResults!['address'].toString();
      price = createdPrice.toString();
      ownerEmail = widget.product['userEmail'].toString();
    });

    if (img1.toString().isEmpty ||
        img1.toString() == "null" ||
        _userPhoneController.text.isEmpty ||
        _userEmailController.text.isEmpty ||
        _productStatusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please fill all fields',
        ),
      ));
      setState(() {
        uploading = false;
      });
      return;
    }

    await _productService.saveRequests(
        img1: img1.toString(),
        location: _productLocationController.text,
        userEmail: _userEmailController.text,
        userPhone: _userPhoneController.text,
        ownerEmail: ownerEmail.toString(),
        price: price.toString(),
        productStatus: _productStatusController.text,
        name: productName.toString(),
        latitude: latitude.toString(),
        longitude: longitude.toString());

    setState(() {
      uploading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Your request have been added successfully wait for a phone call please wait...',
      ),
    ));
    Get.to(() => const HomePage());
  }

  @override
  void initState() {
    super.initState();
    upDatePrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getRequestBody(),
    );
  }

  Widget getRequestBody() {
    return Column(
      children: [
        PikiFittedText(
            text: Text(
          'Your Initial Product Price:\$ ${price.toString()}',
        )),
        PikiFittedText(
            text: Text(
          'Distance:  ${distance.toString()} KM',
        )),
        //show initial price on top
        MyTextFieldWidget(
          controller: _userEmailController,
          hintText: 'Enter Your Email',
          obscureText: false,
          isBigInput: false,
        ),
        MyTextFieldWidget(
          controller: _userPhoneController,
          hintText: 'Enter Your Phone: +263',
          obscureText: false,
          isBigInput: false,
        ),

        MyTextFieldWidget(
          controller: _productStatusController,
          hintText: 'Enter Product Status (New/Old)',
          obscureText: false,
          isBigInput: false,
        ),
        MyTextFieldWidget(
          controller: _productLocationController,
          hintText: 'Enter Your Location (Harare,Zimbabwe)',
          obscureText: false,
          isBigInput: false,
        ),
        uploading
            ? MyCustomBtn(
                buttonText: 'Loading please wait',
                onTap: () {},
              )
            : MyCustomBtn(
                buttonText: 'Request a delivery to your door steps',
                onTap: () {
                  createYourProductRequest();
                },
              ),
      ],
    );
  }
}
