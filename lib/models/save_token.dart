import 'package:cloud_firestore/cloud_firestore.dart';

class cancerconnectorDeviceToken {
  final String email;
  final String token;

  cancerconnectorDeviceToken({
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
