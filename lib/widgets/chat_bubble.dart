import 'package:flutter/material.dart';

import 'app_fitted_text.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.blue,
      ),
      child: PikiFittedText(
        text: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
