import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cancerconnector/json/json_app.dart';
import 'package:cancerconnector/services/create_request_service.dart';
import 'package:cancerconnector/themes/styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/custom_btn.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/my_text_fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var fullNameTextController = TextEditingController();
  var _requestService = CreateRequestService();
  bool isDoctor = false;
  var userProfile = [];
  bool uploading = false;
  var profileImg = "";
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(index: 4),
      body: getBody(size: size),
    );
  }

  Widget getBody({required size}) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          topBar(pageTitle: "Your Profile", size: size),
          profileImg.isEmpty
              ? InkWell(
                  onTap: () {
                    _selectPhoto(imgStateName: 'profileImg');
                  },
                  child: Image.asset(
                    doctors[1]["image"].toString(),
                    height: 70,
                  ),
                )
              : InkWell(
                  onTap: () {
                    _selectPhoto(imgStateName: 'profileImg');
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImg.toString()),
                  ),
                ),
          const SizedBox(
            height: 60,
          ),
          Text(
            doctors[1]["name"],
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/map-pin.png",
                height: 30,
              ),
              Text(doctors[1]!["location"].toString()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Full Name",
              obscureText: false,
              isBigInput: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text("Are you a doctor?"),
                Checkbox(
                    value: isDoctor,
                    onChanged: (data) {
                      setState(() {
                        isDoctor = !isDoctor;
                      });
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Location",
              obscureText: false,
              isBigInput: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextFieldWidget(
              controller: fullNameTextController,
              hintText: "Please Enter Your Bio",
              obscureText: false,
              isBigInput: true,
            ),
          ),
          buildProfile(),
          MyCustomBtn(onTap: () {}, buttonText: "Update Profile"),
        ],
      )),
    );
  }

  Widget buildProfile() {
    return StreamBuilder(
        stream: _requestService.getYourProfile(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Text("Error");
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Text("Loading please wait");
          }
          return Text(snapshots.data!.docs[0]["full_name"].toString());
        });
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
      if (imgStateName.contains('profileImg')) {
        profileImg = downloadUrl;
      } else if (imgStateName.contains('img2')) {
        profileImg = downloadUrl;
      }
    });
  }
}
