import 'package:cancerconnector/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/welcomepage.dart';

class HomeGuard extends StatefulWidget {
  const HomeGuard({super.key});

  @override
  State<HomeGuard> createState() => _HomeGuardState();
}

class _HomeGuardState extends State<HomeGuard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const WelocomePage();
          }
        },
      ),
    );
  }
}
