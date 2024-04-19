import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  final String id;
  DemoScreen({required this.id, super.key});
  @override
  State<StatefulWidget> createState() {
    return _DemoScreen();
  }
}

class _DemoScreen extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
