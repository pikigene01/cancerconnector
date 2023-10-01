import 'package:cancerconnector/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/request_model.dart';

class CreateRequestService extends ChangeNotifier {
  //get instance auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> saveRequest({
    required String location,
    required String description,
    required String? name,
    required String? latitude,
    required String? longitude,
  }) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    RequestHelpModel newRequest = RequestHelpModel(
      name: name.toString(),
      email: currentUserEmail,
      description: description,
      timestamp: timestamp,
      userid: currentUserId,
      longitude: longitude,
      latitude: latitude,
      location: location,
    );

    await _fireStore
        .collection('request')
        .doc('request')
        .collection('all')
        .add(newRequest.toMap());
  }

  Future<void> saveProfile({
    required String location,
    required String description,
    required String? name,
    required String? imageURL,
    required bool isDoctor,
  }) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    ProfileModel newProfile = ProfileModel(
        name: name.toString(),
        email: currentUserEmail,
        isDoctor: isDoctor,
        imageUrl: imageURL.toString(),
        userid: currentUserId,
        description: description,
        location: location,
        timestamp: timestamp);

    await _fireStore.collection('profiles').add(newProfile.toMap());
  }

  Stream<QuerySnapshot> getProfiles({String? latitude, String? longitude}) {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    List<String> ids = [latitude.toString(), longitude.toString()];
    ids.sort();

    return _fireStore
        .collection('profiles')
        .where('isDoctor', isEqualTo: true)
        // .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> updateProfile({required String userEmail}) async {
    //get current user info
    final Timestamp timestamp = Timestamp.now();

    //create a new message
  }

  //Get messages

  Stream<QuerySnapshot> getRequests({String? latitude, String? longitude}) {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    List<String> ids = [latitude.toString(), longitude.toString()];
    ids.sort();

    return _fireStore
        .collection('request')
        .doc('request')
        .collection('all')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getYourProfile() {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    return _fireStore
        .collection('profiles')
        // .doc(_firebaseAuth.currentUser!.uid)
        .where('email', isEqualTo: currentUserEmail.toString())
        .snapshots();
  }

  void updateProfileUser(
      {required imageUrl,
      required name,
      required description,
      required documentId,
      required isDoctor,
      required location}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid.toString();
    DocumentReference documenDeleteReference =
        _fireStore.collection('profiles').doc(documentId);
    await documenDeleteReference.update({
      "name": name,
      "userid": currentUserId,
      "description": description,
      "imageUrl": imageUrl,
      "isDoctor": isDoctor,
      "location": location
    });
  }

  Future<void> deleteYourRequest(
      {required Timestamp timestamp, required documentId}) async {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    // final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    DocumentReference documenDeleteReference = _fireStore
        .collection('request')
        .doc('request')
        .collection('all')
        .doc(documentId);

    await documenDeleteReference
        .delete()
        .whenComplete(() => print('document deleted'))
        .catchError((e) => print(e));
  }
}
