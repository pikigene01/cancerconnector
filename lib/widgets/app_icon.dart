import 'package:flutter/material.dart';

class AppIcon extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final double size;
  const AppIcon(
      {Key? key,
      this.iconColor = const Color(0xFF756d54),
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.size = 45,
      required this.icon})
      : super(key: key);

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          color: widget.backgroundColor),
      child: Icon(
        widget.icon,
        color: widget.iconColor,
        size: 16,
      ),
    );
  }
}
