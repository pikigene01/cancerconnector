import 'package:cancerconnector/pages/home_page.dart';
import 'package:cancerconnector/pages/login.dart';
import 'package:cancerconnector/pages/messagespage.dart';
import 'package:cancerconnector/pages/welcomepage.dart';
import 'package:cancerconnector/services/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageGate extends StatefulWidget {
  const HomePageGate({super.key});

  @override
  State<HomePageGate> createState() => _HomePageGateState();
}

class _HomePageGateState extends State<HomePageGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const AuthGate();
          }
        },
      ),
    );
  }
}
