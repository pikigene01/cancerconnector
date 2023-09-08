import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pikideliveryapp/pages/loginsignin.dart';

import '../pages/chat_screen.dart';
import '../pages/provile_page.dart';

class AuthChatGuard extends StatefulWidget {
  const AuthChatGuard({super.key});

  @override
  State<AuthChatGuard> createState() => _AuthChatGuardState();
}

class _AuthChatGuardState extends State<AuthChatGuard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen(
                title: "Chat Screen",
              );
          } else {
            return const LogInSignUp();
          }
        },
      ),
    );
  }
}
