import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/DoctorModify.dart'; // Import DoctorBloc here
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';

class ListAppoinmentScreen extends StatefulWidget {
  ListAppoinmentScreen({Key? key}) : super(key: key);

  @override
  _ListAppointmnetScreen createState() => _ListAppointmnetScreen();
}

class _ListAppointmnetScreen extends State<ListAppoinmentScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text("List of Appointments"),
      ),
      body: Column(
        children: [
          if (doctorModel!.applicationLeft.isEmpty)
            Center(
              child: Text("No Appointments Found"),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: doctorModel.applicationLeft.length,
                itemBuilder: (context, index) {
                  return Text("Appointment ${index + 1}");
                },
              ),
            ),
        ],
      ),
    );
  }
}
