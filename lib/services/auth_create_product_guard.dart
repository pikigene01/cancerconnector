import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pikideliveryapp/pages/loginsignin.dart';
import '../pages/create_product.dart';

class AuthCreateProductGuard extends StatefulWidget {
  const AuthCreateProductGuard({super.key});

  @override
  State<AuthCreateProductGuard> createState() => _AuthCreateProductGuardState();
}

class _AuthCreateProductGuardState extends State<AuthCreateProductGuard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const UserCreateProduct();
          } else {
            return const LogInSignUp();
          }
        },
      ),
    );
  }
}
