import 'package:flutter/material.dart';

class Loder extends StatelessWidget {
  Loder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
