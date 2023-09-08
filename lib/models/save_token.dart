import 'package:cloud_firestore/cloud_firestore.dart';

class PikiDeliveryAppDeviceToken {
  final String email;
  final String token;

  PikiDeliveryAppDeviceToken({
    required this.email,
    required this.token,
  });

  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': token,
    };
  }
}
