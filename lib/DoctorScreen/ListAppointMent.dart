import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/DoctorScreen/BottomNavigation.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/DoctorScreen/bloc/delete_appointment_bloc.dart';
import 'package:med_ease/DoctorScreen/bloc/refresh_doctor_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/bloc/user_moduel_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ListAppointmentScreen extends StatefulWidget {
  ListAppointmentScreen({Key? key}) : super(key: key);

  @override
  _ListAppointmentScreenState createState() => _ListAppointmentScreenState();
}

class _ListAppointmentScreenState extends State<ListAppointmentScreen> {
  void delete(
      {required String doctorId,
      required String userID,
      required String appointMentId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: SizedBox(
            width: 300, // Adjust width as needed
            child: Text("Are you sure to Cancel?"),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                deleteAppointment(
                    appointMentId: appointMentId,
                    doctorId: doctorId,
                    userID: userID);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void deleteAppointment(
      {required String doctorId,
      required String userID,
      required String appointMentId}) {
    final refreshDoctorModule = BlocProvider.of<RefreshDoctorBloc>(context);
    refreshDoctorModule.add(deleteAppointEvent(
        appointMentId: appointMentId,
        context: context,
        doctorId: doctorId,
        userId: userID));
    Navigator.of(context).pop();
  }

  // void onCompleted(
  //     {required String text,
  //     required String doctorId,
  //     required String userID}) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Confirmation"),
  //         content: Text(text),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Dismiss the dialog
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //              deleteAppointment(doctorId: doctorId, userID: userID);
  //             },
  //             child: Text("Submit to History"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    final refreshDoctorModule = BlocProvider.of<RefreshDoctorBloc>(context);

    return BlocConsumer<RefreshDoctorBloc, RefreshDoctorState>(
      listener: (context, state) {
        if (state is RefreshDoctorFailure) {
          showSnackBar(state.error, context);
        }
        if (state is RefreshDoctorSuccess) {
          final doctorBloc = context.read<DoctorBloc>();
          doctorBloc.updateDoctor(state.doctor);
        }
        if (state is updateIsCompleteSuccess) {
          final doctorBloc = context.read<DoctorBloc>();
          doctorBloc.updateDoctor(state.doctor);
          // onCompleted(
          //     text: state.successText,
          //     doctorId: state.doctor.id,
          //     userID: state.userId);

          // showSnackBar(state.successText, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("List of Appointments"),
            actions: [
              IconButton(
                onPressed: () => refreshDoctorModule.add(RefreshDoctorListEvent(
                    context: context, doctorId: doctorModel!.id)),
                icon: Icon(Icons.refresh_rounded),
              )
            ],
          ),
          body: doctorModel!.applicationLeft.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Appointments Found",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: doctorModel.applicationLeft.length,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = doctorModel.applicationLeft[index];
                    if (state is RefreshDoctorLoding) {
                      return Loder(); // Assuming Loder is a custom loading widget
                    }
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  //  MessageScreen(
                                  //   userId: appointment.userId ?? '',
                                  //   appointMentId: appointment.id ?? '',
                                  //   doctorID: doctorModel.id,
                                  // ),
                                  MessageScreen(
                                      userId: appointment.userId ?? '',
                                      isDoctor: true,
                                      doctorID: doctorModel.id)),
                        ),
                        title: Text('Appointment ID: ${appointment.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User ID: ${appointment.userId}'),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  appointment.appointMentDetails!.map((detail) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Date: ${detail.date}'),
                                      Text(
                                        'TimeSlotSelected: ${detail.timeSlotPicks!.timeSlots![0].hour}:${detail.timeSlotPicks!.timeSlots![0].minute}',
                                      ),
                                      Text('User ID: ${detail.userId}'),
                                      Text('Is Complete: ${detail.isComplete}'),
                                      Divider(),
                                      detail.isComplete == false
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    refreshDoctorModule.add(
                                                        updateIsCompleteEvent(
                                                            appointMentId:
                                                                detail.id ?? '',
                                                            context: context,
                                                            doctorId:
                                                                doctorModel.id,
                                                            userId:
                                                                detail.userId ??
                                                                    ''));
                                                  },
                                                  icon: Icon(Icons.done),
                                                  label: Text("Done"),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    delete(
                                                      appointMentId:
                                                          detail.id ?? "",
                                                      doctorId:
                                                          detail.doctorId ?? '',
                                                      userID:
                                                          detail.userId ?? '',
                                                    );
                                                  },
                                                  icon: Icon(
                                                      detail.isComplete == false
                                                          ? Icons.cancel
                                                          : Icons.done),
                                                  label:
                                                      detail.isComplete == false
                                                          ? Text("Cancel")
                                                          : Text("Done"),
                                                ),
                                              ],
                                            )
                                          : Column(children: [
                                              RatingBar.builder(
                                                itemCount: 5,
                                                initialRating: double.parse(
                                                    detail.rating ?? "0.0"),
                                                itemBuilder: (context, _) {
                                                  return Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  );
                                                },
                                                onRatingUpdate: (value) {},
                                              ),
                                              Text(
                                                  "Comments: ${detail.comments ?? "0"}"),
                                              detail.comments != "" ||
                                                      detail.rating != ""
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        refreshDoctorModule.add(
                                                            deleteAppointEvent(
                                                                appointMentId:
                                                                    detail.id ??
                                                                        "",
                                                                context:
                                                                    context,
                                                                doctorId: detail
                                                                        .doctorId ??
                                                                    '',
                                                                userId: detail
                                                                        .userId ??
                                                                    ''));
                                                      },
                                                      child:
                                                          Text("Save History"))
                                                  : Text(
                                                      "Review is Not Completed",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                            ])
                                    ]);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
