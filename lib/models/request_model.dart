import 'package:cloud_firestore/cloud_firestore.dart';

class RequestHelpModel {
  final String name;
  final String description;
  final String email;
  final String location;
  final String? longitude;
  final String? latitude;
  final String? userid;
  final Timestamp timestamp;

  RequestHelpModel({
    required this.name,
    required this.description,
    required this.email,
    required this.timestamp,
    required this.location,
    required this.userid,
    this.longitude,
    this.latitude,
  });

  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'description': description,
      'name': name,
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'user_id': userid,
      'timestamp': timestamp,
    };
  }
}
