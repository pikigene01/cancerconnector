import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:pikideliveryapp/pages/home_page.dart';
import '../services/geo_locator_service.dart';
import '../services/product_service.dart';
import '../themes/styles.dart';
import '../widgets/bottombar.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/my_text_field.dart';
import '../widgets/piki_app_ads.dart';
import '../widgets/product.dart';
import '../widgets/request_product.dart';

class UserCreateProduct extends StatefulWidget {
  const UserCreateProduct({super.key});

  @override
  State<UserCreateProduct> createState() => _UserCreateProductState();
}

class _UserCreateProductState extends State<UserCreateProduct> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final geoloocationService = GeoLocationService();

  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();
  final TextEditingController _productLocationController =
      TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productStatusController =
      TextEditingController();
  String? img1 = "";
  String? img2 = "";
  double? longitude;
  double? latitude;
  String? addressFromLocation = "";
  bool uploading = false;
  final ImagePicker _picker = ImagePicker();

  final _productService = ProductService();

  void createProduct() async {
    setState(() {
      uploading = true;
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
      longitude = geolocationResults!['longitude'];
      latitude = geolocationResults!['latitude'];
      addressFromLocation = geolocationResults!['address'].toString();
      _productLocationController.text =
          geolocationResults!['address'].toString();
    });

    if (img1.toString().isEmpty ||
        _productDescriptionController.text.isEmpty ||
        _userPhoneController.text.isEmpty ||
        _userEmailController.text.isEmpty ||
        _productPriceController.text.isEmpty ||
        _productCategoryController.text.isEmpty ||
        _productLocationController.text.isEmpty ||
        _productNameController.text.isEmpty ||
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
    var result = await _productService.saveProduct(
        name: _productNameController.text,
        userEmail: _userEmailController.text,
        userPhone: _userPhoneController.text,
        productDescription: _productDescriptionController.text,
        location: _productLocationController.text,
        img1: img1,
        img2: img2,
        productStatus: _productStatusController.text,
        price: _productPriceController.text,
        longitude: geolocationResults!['longitude'],
        latitude: geolocationResults!['latitude'],
        category: _productCategoryController.text);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Your Item Created Successfully...',
      ),
    ));
    setState(() {
      uploading = false;
    });
    Get.to(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Create', icon: Icon(Icons.plus_one)),
                Tab(
                    text: 'Products',
                    icon: Icon(Icons.production_quantity_limits)),
                Tab(text: 'Product Requests', icon: Icon(Icons.car_rental)),
              ],
            ),
            title: Text(
              'logged in as ${_auth.currentUser!.email}',
              style: const TextStyle(fontSize: 10),
            ),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.arrowDown),
              ),
            ],
          ),
          body: getBody(),
          bottomNavigationBar: const BottomBar(
            index: 4,
          ),
        ));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PikiDeliveryAds(),
                const SizedBox(
                  height: 20,
                ),
                MyTextFieldWidget(
                  controller: _productNameController,
                  hintText: 'Enter Product Name',
                  obscureText: false,
                  isBigInput: false,
                ),
                MyTextFieldWidget(
                  controller: _productDescriptionController,
                  hintText: 'Enter Product Description',
                  obscureText: false,
                  isBigInput: true,
                ),
                MyTextFieldWidget(
                  controller: _userEmailController,
                  hintText: 'Owner Email',
                  obscureText: false,
                  isBigInput: false,
                ),
                MyTextFieldWidget(
                  controller: _userPhoneController,
                  hintText: 'Owner Phone: +263',
                  obscureText: false,
                  isBigInput: false,
                ),
                MyTextFieldWidget(
                  controller: _productPriceController,
                  hintText: 'USD Price',
                  obscureText: false,
                  keyboardType: true,
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
                  hintText: 'Enter Product Location (Harare,Zimbabwe)',
                  obscureText: false,
                  isBigInput: false,
                ),
                MyTextFieldWidget(
                  controller: _productCategoryController,
                  hintText: 'Enter Product Category fall under',
                  obscureText: false,
                  isBigInput: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Please choose your product imgs',
                    style: appStyleTextActive),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      img1!.isEmpty
                          ? InkWell(
                              onTap: () {
                                _selectPhoto(imgStateName: 'img1');
                              },
                              child: const FaIcon(FontAwesomeIcons.plus))
                          : CachedNetworkImage(
                              width: 200,
                              height: 200,
                              imageUrl: img1.toString()),
                      const SizedBox(
                        width: 20,
                      ),
                      img2!.isEmpty
                          ? InkWell(
                              onTap: () {
                                _selectPhoto(imgStateName: 'img2');
                              },
                              child: const FaIcon(FontAwesomeIcons.plus))
                          : CachedNetworkImage(
                              width: 90, height: 90, imageUrl: img2.toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                !uploading
                    ? MyCustomBtn(
                        buttonText: 'Create New Product',
                        onTap: () {
                          createProduct();
                        },
                      )
                    : MyCustomBtn(
                        buttonText: 'Loading please wait.....',
                        onTap: () {},
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _buildProductssList(width: size.width),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _buildProductRequestsList(width: size.width),
              ],
            ),
          ),
        ),
      ],
    ); // TabBarView
  }

  Widget _buildProductRequestsList({required width}) {
    return StreamBuilder(
      stream: _productService.getUserRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Request Loading please wait..');
        }
        return Column(
          children: List.generate(snapshot.data!.docs.length, (index) {
            return productRequestItem(
              width: width,
              data: snapshot.data!.docs[index],
              onTap: () {
                _productService.deleteYourRequest(
                    timestamp: snapshot.data!.docs[index]['timestamp'],
                    documentId: snapshot.data!.docs[index].id);
              },
            );
          }),
        );
      },
    );
  }

  Widget _buildProductssList({required width}) {
    return StreamBuilder(
      stream: _productService.getYourProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Messages Loading please wait..');
        }
        return Column(
          children: List.generate(snapshot.data!.docs.length, (index) {
            return productItem(
              width: width,
              data: snapshot.data!.docs[index],
              from: 'dashboard',
              onTap: () {
                _productService.deleteYourProducts(
                    timestamp: snapshot.data!.docs[index]['timestamp'],
                    documentId: snapshot.data!.docs[index].id);
              },
            );
          }),
        );
      },
    );
  }

  Future _selectPhoto({required imgStateName}) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Camera'),
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(
                              source: ImageSource.camera,
                              imgStateName: imgStateName);
                        }),
                    ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('Pick your product image'),
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(
                              source: ImageSource.gallery,
                              imgStateName: imgStateName);
                        }),
                  ],
                )));
  }

  Future _pickImage(
      {required ImageSource source, required imgStateName}) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    await _uploadFile(path: file.path, imgStateName: imgStateName);
  }

  Future _uploadFile({String? path, required imgStateName}) async {
    setState(() {
      uploading = true;
    });
    Reference reference = storage.FirebaseStorage.instance.ref(path);

    final TaskSnapshot snapshot =
        await reference.putFile(File(path.toString()));

    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      uploading = false;
      if (imgStateName.contains('img1')) {
        img1 = downloadUrl;
      } else if (imgStateName.contains('img2')) {
        img2 = downloadUrl;
      }
    });
  }
}
