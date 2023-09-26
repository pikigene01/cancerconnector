import 'package:flutter/material.dart';

import '../themes/styles.dart';

class MyCustomBtn extends StatefulWidget {
  final void Function()? onTap;
  final String? buttonText;
  const MyCustomBtn({super.key, required this.onTap, required this.buttonText});

  @override
  State<MyCustomBtn> createState() => _MyCustomBtnState();
}

class _MyCustomBtnState extends State<MyCustomBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(
              widget.buttonText.toString(),
              style: appStyleText,
            ),
          ),
        ),
      ),
    );
  }
}
