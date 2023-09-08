import 'package:cloud_firestore/cloud_firestore.dart';

class UserProductRequest {
  final String name;
  final String userPhone;
  final String userEmail;
  final String ownerEmail;
  final String location;
  final String? longitude;
  final String? latitude;
  final String? img1;
  final String? price;
  final String? productStatus;
  final Timestamp timestamp;

  UserProductRequest({
    required this.userPhone,
    required this.name,
    required this.userEmail,
    required this.ownerEmail,
    required this.timestamp,
    required this.location,
    this.longitude,
    this.latitude,
    this.img1,
    this.price,
    this.productStatus,
  });

  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'userPhone': userPhone,
      'userEmail': userEmail,
      'ownerEmail': ownerEmail,
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'img1': img1,
      'price': price,
      'productStatus': productStatus,
      'timestamp': timestamp,
    };
  }
}
