import 'package:flutter/material.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/DoctorModule.dart';

class CardDoctorDetails extends StatefulWidget {
  final DoctorModuleE doctorModule;
  CardDoctorDetails({required this.doctorModule, super.key});
  @override
  State<StatefulWidget> createState() {
    return _CardDetailsScreeen();
  }
}

class _CardDetailsScreeen extends State<CardDoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctorModule.name),
      ),
    );
  }
}
