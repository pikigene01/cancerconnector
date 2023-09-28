import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String name;
  final String email;
  final String imageUrl;
  final String location;
  final String description;
  final bool isDoctor;
  final Timestamp timestamp;

  ProfileModel(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.description,
      required this.location,
      required this.isDoctor,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "description": description,
      "imageUrl": imageUrl,
      "location": location,
      "isDoctor": isDoctor,
      "timestamp": timestamp
    };
  }
}
