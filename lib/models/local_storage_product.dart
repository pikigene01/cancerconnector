import 'package:cloud_firestore/cloud_firestore.dart';

class UserProductLocalStorage {
  final String userPhone;
  final String name;
  final String userEmail;
  final String productDescription;
  final String location;
  final String? longitude;
  final String? latitude;
  final String? category;
  final String? img1;
  final String? img2;
  final String? price;
  final String? productStatus;
  final Timestamp timestamp;

  UserProductLocalStorage({
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
  Map<String, Object> values = <String, Object>{'counter': 1};
  Map<String, Object> toMap() {
    return {
      'userPhone': userPhone,
      'name': name,
      'userEmail': userEmail,
      'productDescription': productDescription,
      'location': location,
      'longitude': location,
      'latitude': latitude.toString(),
      'img1': img1.toString(),
      'img2': img2.toString(),
      'price': price.toString(),
      'category': category.toString(),
      'productStatus': productStatus.toString(),
      'timestamp': timestamp,
    };
  }
}
