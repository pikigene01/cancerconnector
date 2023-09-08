import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pikideliveryapp/pages/home_page.dart';

import '../models/save_token.dart';
import '../models/send_notification_model.dart';
import 'package:http/http.dart' as Http;

Future<void> _firebasebackgroundhandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Title: ${message.data}');
}

class PikiDeliveryNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    // if (_firebaseAuth.currentUser!.email.toString().isNotEmpty) {
    // final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

    //   PikiDeliveryAppDeviceToken newToken = PikiDeliveryAppDeviceToken(
    //     email: currentUserEmail,
    //     token: fCMToken.toString(),
    //   );
    //   await _fireStore
    //       .collection('device')
    //       .doc('users')
    //       .collection('token')
    //       .add(newToken.toMap());
    // }
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(_firebasebackgroundhandler);
    initPushNotifications();
  }

  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    _firebaseMessaging
        .getInitialMessage()
        .then((value) => handleMessage(value));
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event);
    });
    FirebaseMessaging.onBackgroundMessage(_firebasebackgroundhandler);
  }

  void handleMessage(value) {
    if (value == null) return;
    Get.to(() => const HomePage());
  }

  Future<void> sendNotification(
      {required String deviceId,
      required String title,
      required String body}) async {
    PikiDeliveryAppNotificationMessage newMessage =
        PikiDeliveryAppNotificationMessage(title: title, body: body);

    // await _firebaseMessaging.sendMessage(to: deviceId, data: {
    //   'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //   'id': '1',
    //   'status': 'done',
    //   'body': body,
    //   'title': title,
    // });
    try {
      await Http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'AAAAGe0GVps:APA91bGNoNmxMM7DiBUxqMZKMUaub38o7C2tl439TwTPvqVUCFHn4byWSMyrkH0MTQr7DSUlfeRsLyAq0I_TRkuiMwrYz8vCuECBe5xfxYl6o4QSvHGqLYPod8mSf6Se8CSx9Ydrzvnu',
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                'title': title,
                'body': body,
                'android_channel_id': 'pikideliveryapp'
              },
              "to": deviceId,
            },
          ));
    } catch (e) {
      print('Get App Data: ${e.toString()}');
    }
    // ;
  }
}
