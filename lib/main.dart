import 'package:cancerconnector/firebase_options.dart';
import 'package:cancerconnector/pages/splash_screen.dart';
import 'package:cancerconnector/pages/welcomepage.dart';
import 'package:cancerconnector/services/home_page_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cancerconnector/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var loading = true;
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePageGate(),
      ),
    ),
  );
}
