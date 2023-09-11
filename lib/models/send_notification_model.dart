import 'package:cloud_firestore/cloud_firestore.dart';

class CancerconnectorNotificationMessage {
  final String title;
  final String body;

  CancerconnectorNotificationMessage({
    required this.title,
    required this.body,
  });

  //convert to a map

  Map toMap() {
    return {
      'title': title,
      'body': body,
    };
  }
}
