import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/src/style.dart';

class HtmlPage extends StatefulWidget {
  const HtmlPage({super.key});

  @override
  State<HtmlPage> createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  final _htmlData = """
    <style>
    *{
      text-decoration: none;
    }
    h1{
      font-size: 53px;
    }
    </style>
    <div>
    <h1>PikiDelivery</h1>
    </div>
  """;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Html(
          data: _htmlData,
          style: {'h1': Style(color: Colors.white)},
        ),
      ),
    );
  }
}
