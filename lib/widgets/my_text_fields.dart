import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final bool isBigInput;
  final bool keyboardType;
  const MyTextFieldWidget(
      {super.key,
      required this.hintText,
      this.controller,
      required this.obscureText,
      required this.isBigInput,
      this.keyboardType = false});

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var hintText = widget.hintText;
    return widget.isBigInput
        ? DescriptionWidget(
            widget: widget,
            hintText: hintText,
            keyboardType: widget.keyboardType)
        : widget.keyboardType
            ? PhoneWidget(
                widget: widget,
                hintText: hintText,
                keyboardType: widget.keyboardType)
            : TextWidget(
                widget: widget,
                hintText: hintText,
                keyboardType: widget.keyboardType);
  }
}

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    super.key,
    required this.widget,
    required this.hintText,
    this.keyboardType,
  });

  final MyTextFieldWidget widget;
  final String? hintText;
  final bool? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.grey.shade400,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.widget,
    required this.hintText,
    this.keyboardType,
  });

  final MyTextFieldWidget widget;
  final String? hintText;
  final bool? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        expands: true,
        maxLines: null,
        keyboardType: TextInputType.text,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey.shade400,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.widget,
    required this.hintText,
    this.keyboardType,
  });

  final MyTextFieldWidget widget;
  final String? hintText;
  final bool? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.grey.shade400,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
