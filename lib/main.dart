import 'package:cancerconnector/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cancerconnector/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}
