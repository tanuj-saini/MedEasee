import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UserScreens/utils/AppointMentHistoryCard.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart'; // Import your modules

class AppointmentHistoryLessUser extends StatelessWidget {
  final AppointmentLeft appointment;

  const AppointmentHistoryLessUser({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Date: ${appointment.date}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Doctor ID: ${appointment.doctorId ?? "Unknown"}'),
              SizedBox(height: 8.0),
              Text('AppointMent ID: ${appointment.id ?? "Unknown"}'),
              SizedBox(height: 8.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => AppointmentHistoryCardUser(
                              appointment: appointment,
                            )));
                  },
                  child: Text("More Details"))
            ]),
      ),
    );
  }
}
