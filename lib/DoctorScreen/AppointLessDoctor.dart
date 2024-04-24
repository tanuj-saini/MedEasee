import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/DoctorScreen/AppointDoctorCard.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart'; // Import your modules

class AppointmentHistorylessDoctor extends StatefulWidget {
  final AppointMentDetails appointment;

  const AppointmentHistorylessDoctor({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<AppointmentHistorylessDoctor> createState() =>
      _AppointmentHistorylessDoctorState();
}

class _AppointmentHistorylessDoctorState
    extends State<AppointmentHistorylessDoctor> {
  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Date: ${widget.appointment.date}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Doctor ID: ${widget.appointment.doctorId ?? "Unknown"}'),
            SizedBox(height: 8.0),
            Text('AppointMent ID: ${widget.appointment.id ?? "Unknown"}'),
            SizedBox(height: 8.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => AppointmentHistoryCardDoctor(
                            appointment: widget.appointment,
                          )));
                },
                child: Text("Message from User"))
          ],
        ),
      ),
    );
  }
}
