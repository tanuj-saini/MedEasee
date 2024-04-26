import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/DoctorScreen/bloc/refresh_doctor_bloc.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/testUserModule.dart'; // Import your user module
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:rating_dialog/rating_dialog.dart'; // Import any necessary models

class BookedAppointmentList extends StatefulWidget {
  BookedAppointmentList({Key? key}) : super(key: key); // Corrected super call
  @override
  _BookedAppointmentListState createState() => _BookedAppointmentListState();
}

class _BookedAppointmentListState extends State<BookedAppointmentList> {
  void show(
      {required String doctorId,
      required String userId,
      required String appointMentId}) {
    showDialog(
      context: context,
      builder: (context) {
        return RatingDialog(
          title: Text("How was your Experience!!"),
          submitButtonText: "Submit",
          onSubmitted: (review) {
            final refreshDoctorModule =
                BlocProvider.of<RefreshDoctorBloc>(context);
            refreshDoctorModule.add(updateRatingCompleted(
                context: context,
                doctorId: doctorId,
                userId: userId,
                appointMentId: appointMentId,
                comments: review.comment,
                rating: review.rating.toString()));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBloc>().state as UserModuleE;
    print(user.age);
    print(user.appointment.length);
    final refreshDoctorModule = BlocProvider.of<RefreshDoctorBloc>(context);
    return BlocConsumer<RefreshDoctorBloc, RefreshDoctorState>(
      listener: (context, state) {
        if (state is RefreshDoctorFailure) {
          showSnackBar(state.error.toString(), context);
        }
        if (state is DeleteAppointSuccess) {
          final userBloc = context.read<UserBloc>();
          userBloc.updateUser(state.user);

          showSnackBar(state.successText, context);
        }
        if (state is updateCommetsRatingSucess) {
          final userBloc = context.read<UserBloc>();
          userBloc.updateUser(state.user);
        }
      },
      builder: (context, state) {
        if (state is RefreshDoctorLoding) {
          return Loder();
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Booked Appointment"),
            ),
            body: user.appointment.length == 0
                ? Center(
                    child: Text("No Appointments has been Book Yet"),
                  )
                : ListView.builder(
                    itemCount: user.appointment.length,
                    itemBuilder: (BuildContext context, int index) {
                      final appointment = user.appointment[index];
                      return Card(
                        child: ListTile(
                          onTap: () {},
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Doctor ID: ${appointment.doctorId}'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    appointment.apppointLeft!.map((detail) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("AppointMent Id:${detail.id}"),
                                      Text('Date: ${detail.date}'),
                                      Text('User ID: ${detail.userId}'),
                                      Text('Is Complete: ${detail.isComplete}'),
                                      Text('Is Vedio: ${detail.isVedio}'),
                                      Text(
                                          'TimeSlotSelected:${detail.timeSlotPicks!.timeSlots![0].hour}:${detail.timeSlotPicks!.timeSlots![0].minute}'),
                                      Divider(),
                                      detail.isComplete == false
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Cancel Fee may Charge:",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      refreshDoctorModule.add(
                                                          deleteAppointEventUser(
                                                              appointMentId:
                                                                  detail.id ??
                                                                      "",
                                                              context: context,
                                                              doctorId: appointment
                                                                      .doctorId ??
                                                                  "",
                                                              userId: detail
                                                                      .userId ??
                                                                  ""));
                                                    },
                                                    icon: Icon(Icons.cancel),
                                                    label: Text("Cancel")),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      show(
                                                          doctorId: appointment
                                                                  .doctorId ??
                                                              "",
                                                          userId:
                                                              detail.userId ??
                                                                  "",
                                                          appointMentId:
                                                              detail.id ?? "");
                                                    },
                                                    icon: Icon(Icons
                                                        .remove_circle_outline_outlined),
                                                    label: Text("Review")),
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      refreshDoctorModule.add(
                                                          deleteAppointEventUser(
                                                        appointMentId:
                                                            detail.id ?? "",
                                                        context: context,
                                                        doctorId: appointment
                                                                .doctorId ??
                                                            "",
                                                        userId:
                                                            detail.userId ?? "",
                                                      ));
                                                    },
                                                    icon: Icon(Icons.done),
                                                    label: Text("Done")),
                                              ],
                                            )
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
      },
    );
  }
}
