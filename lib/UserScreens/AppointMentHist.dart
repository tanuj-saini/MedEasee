import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/DoctorScreen/bloc/hist_appoint_bloc.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/utils/AppointMentHistoryCard.dart';

class AppointHisUser extends StatefulWidget {
  final String userId;
  AppointHisUser({required this.userId, super.key});
  @override
  State<StatefulWidget> createState() {
    return _AppointHisUser();
  }
}

class _AppointHisUser extends State<AppointHisUser> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBloc>().state;

    List<AppointmentLeft>? appointmentHistory = user?.appointMentHistory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment History'),
      ),
      body: appointmentHistory != null && appointmentHistory.isNotEmpty
          ? ListView.builder(
              itemCount: appointmentHistory.length,
              itemBuilder: (context, index) {
                return AppointmentHistoryCardUser(
                  appointment: appointmentHistory[index],
                );
              },
            )
          : Center(
              child: Text(
                'No Appointments',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
    );
  }
}
