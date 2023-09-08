import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/product_request_model.dart';
import '../models/save_token.dart';
import 'app_firebase_notifications.dart';

class ProductService extends ChangeNotifier {
  //get instance auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _firebaseNotifications = PikiDeliveryNotifications();

  Future<void> saveProduct(
      {required String? userEmail,
      String? img1,
      String? img2,
      required String userPhone,
      required String productDescription,
      required String location,
      required String name,
      required double latitude,
      required double longitude,
      String? price,
      String? category,
      String? productStatus}) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    print('Longitude from back: ${longitude.toDouble()}');

    //create a new message
    UserProduct newProduct = UserProduct(
      name: name,
      userPhone: userPhone,
      img1: img1,
      img2: img2,
      userEmail: currentUserEmail,
      timestamp: timestamp,
      productDescription: productDescription,
      longitude: longitude.toDouble(),
      latitude: latitude.toDouble(),
      category: category,
      productStatus: productStatus,
      price: price,
      location: location,
    );

    await _fireStore
        .collection('products')
        .doc('products')
        .collection('items')
        .add(newProduct.toMap());
  }

  Future<void> saveRequests(
      {required String userEmail,
      required String img1,
      required String userPhone,
      required String location,
      required String name,
      String? latitude,
      String? longitude,
      required String ownerEmail,
      String? price,
      String? category,
      String? productStatus}) async {
    //get current user info
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    UserProductRequest newProduct = UserProductRequest(
      name: name,
      userPhone: userPhone,
      img1: img1,
      userEmail: userEmail,
      ownerEmail: ownerEmail,
      timestamp: timestamp,
      location: location,
      latitude: latitude,
      longitude: longitude,
      productStatus: productStatus,
      price: price,
    );

    await _fireStore
        .collection('products')
        .doc('requests')
        .collection('items')
        .add(newProduct.toMap());

    // await _fireStore
    //     .collection('device')
    //     .doc('users')
    //     .collection('token')
    //     .where('email', isEqualTo: ownerEmail)
    //     .snapshots()
    //     .forEach((element) async {
    //   await _firebaseNotifications.sendNotification(
    //       deviceId: element.docs[0].data()['token'].toString(),
    //       title: 'You have new Request',
    //       body: '$userEmail send you a new product request');
    // });

    // await _firebaseNotifications.sendNotification(
    //     deviceId:
    //         'e0GUl9-1SMKQZCHo5WJdX6:APA91bHR79kKHuwAWXLIBS6KrTQbNrO0xkUnRsFJGikHjKZeZVi0p9sj7XmPlRaCgV9zAJKMa_926Fq3ds6qM2e9rY7U16AEkYD4nE2yGZT_ge00nssa5QH_NnQl-1TeS39sqpgE2Bjw',
    //     title: 'You have new Request',
    //     body: '$userEmail send you a new product request');
  }

  //Get messages

  Stream<QuerySnapshot> getProducts({String? latitude, String? longitude}) {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    List<String> ids = [latitude.toString(), longitude.toString()];
    ids.sort();

    return _fireStore
        .collection('products')
        .doc('products')
        .collection('items')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserRequests() {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    return _fireStore
        .collection('products')
        .doc('requests')
        .collection('items')
        .orderBy('timestamp', descending: true)
        // .where('ownerEmail', isEqualTo: currentUserEmail.toString())
        .snapshots();
  }

  Stream<QuerySnapshot> getYourProducts() {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    return _fireStore
        .collection('products')
        .doc('products')
        .collection('items')
        .where('userEmail', isEqualTo: currentUserEmail.toString())
        .snapshots();
  }

  Future<void> deleteYourProducts(
      {required Timestamp timestamp, required documentId}) async {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    // final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    DocumentReference documenDeleteReference = _fireStore
        .collection('products')
        .doc('products')
        .collection('items')
        .doc(documentId);

    await documenDeleteReference
        .delete()
        .whenComplete(() => print('document deleted'))
        .catchError((e) => print(e));
  }

  Future<void> deleteYourRequest(
      {required Timestamp timestamp, required documentId}) async {
    //construct chat room id from user ids sorted to ensure it matches the id when sending the message
    // final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    DocumentReference documenDeleteReference = _fireStore
        .collection('products')
        .doc('requests')
        .collection('items')
        .doc(documentId);

    await documenDeleteReference
        .delete()
        .whenComplete(() => print('request deleted successfully'))
        .catchError((e) => print(e));
  }
}
