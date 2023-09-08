import 'package:flutter/material.dart';

class PikiFittedText extends StatefulWidget {
  final Text text;
  const PikiFittedText({super.key, required this.text});

  @override
  State<PikiFittedText> createState() => _PikiFittedTextState();
}

class _PikiFittedTextState extends State<PikiFittedText> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: widget.text,
    );
  }
}
