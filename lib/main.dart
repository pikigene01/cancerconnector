import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cancerconnector/firebase_options.dart';
import 'package:cancerconnector/services/app_firebase_notifications.dart';
import 'package:cancerconnector/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';

void main() async {
  var devices = ["D0C0D0CE37FC4D173ECDCCEDEDD8583"];
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  await cancerconnectorNotifications().initNotifications();
  await MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}
