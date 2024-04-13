import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/testUserModule.dart'; // Import your user module
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart'; // Import any necessary models

class BookedAppointmentList extends StatefulWidget {
  BookedAppointmentList({Key? key}) : super(key: key); // Corrected super call
  @override
  _BookedAppointmentListState createState() => _BookedAppointmentListState();
}

class _BookedAppointmentListState extends State<BookedAppointmentList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBloc>().state as UserModuleE;
    print(user.age);
    print(user.appointment.length);
    return Scaffold(
        appBar: AppBar(
          title: Text("Booked Appointment"),
        ),
        body: ListView.builder(
          itemCount: user.appointment.length,
          itemBuilder: (BuildContext context, int index) {
            final appointment = user.appointment[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MessageScreen(
                      userId: user.id,
                      appointMentId: appointment.id ?? '',
                      doctorID: appointment.doctorId ?? "",
                    ),
                  ));
                },
                title: Text('Appointment ID: ${appointment.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Doctor ID: ${appointment.doctorId}'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: appointment.apppointLeft!.map((detail) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${detail.date}'),
                            Text('User ID: ${detail.userId}'),
                            Text('Is Complete: ${detail.isComplete}'),
                            Divider(),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
