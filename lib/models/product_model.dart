import 'package:cloud_firestore/cloud_firestore.dart';

class UserProduct {
  final String userPhone;
  final String name;
  final String userEmail;
  final String productDescription;
  final String location;
  final double? longitude;
  final double? latitude;
  final String? category;
  final String? img1;
  final String? img2;
  final String? price;
  final String? productStatus;
  final Timestamp timestamp;

  UserProduct({
    required this.userPhone,
    required this.name,
    required this.userEmail,
    required this.productDescription,
    required this.timestamp,
    required this.location,
    this.longitude,
    this.latitude,
    this.category,
    this.img1,
    this.img2,
    this.price,
    this.productStatus,
  });

  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'userPhone': userPhone,
      'name': name,
      'userEmail': userEmail,
      'productDescription': productDescription,
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'img1': img1,
      'img2': img2,
      'price': price,
      'category': category,
      'productStatus': productStatus,
      'timestamp': timestamp,
    };
  }
}
