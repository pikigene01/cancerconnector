import 'package:cloud_firestore/cloud_firestore.dart';

class cancerconnectorNotificationMessage {
  final String title;
  final String body;

  cancerconnectorNotificationMessage({
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
