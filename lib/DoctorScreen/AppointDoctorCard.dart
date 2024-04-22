import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart'; // Import your modules

class AppointmentHistoryCardDoctor extends StatelessWidget {
  final AppointMentDetails appointment;

  const AppointmentHistoryCardDoctor({Key? key, required this.appointment})
      : super(key: key);

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
              'Date: ${appointment.date}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Doctor ID: ${appointment.doctorId ?? "Unknown"}'),
            SizedBox(height: 8.0),
            Text('Comments: ${appointment.comments ?? "No comments"}'),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            Text('Is Video Appointment: ${appointment.isVedio ?? false}'),
            SizedBox(height: 8.0),
            Text('Is Complete: ${appointment.isComplete ?? false}'),
            SizedBox(height: 8.0),
            if (appointment.timeSlotPicks != null)
              Text('Time Slot: ${appointment.timeSlotPicks!.toJson()}'),
            if (appointment.rating != null)
              RatingBar.builder(
                initialRating: double.parse(appointment.rating!),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Handle rating update
                },
              ),
            SizedBox(height: 8.0),
            double.parse(appointment.rating!) <= 2
                ? TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MessageScreen(
                              userId: appointment.userId ?? "",
                              isDoctor: true,
                              doctorID: appointment.doctorId ?? "")));
                    },
                    icon: Icon(Icons.message),
                    label: Text("Message"))
                : Container()
          ],
        ),
      ),
    );
  }
}
