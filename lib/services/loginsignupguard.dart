import 'package:cancerconnector/pages/login.dart';
import 'package:cancerconnector/services/home_guard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/welcomepage.dart';

class LoginSignUpGuard extends StatefulWidget {
  const LoginSignUpGuard({super.key});

  @override
  State<LoginSignUpGuard> createState() => _LoginSignUpGuardState();
}

class _LoginSignUpGuardState extends State<LoginSignUpGuard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeGuard();
          } else {
            return const LogInSignUp();
          }
        },
      ),
    );
  }
}
