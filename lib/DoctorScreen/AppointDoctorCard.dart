import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/bloc/list_chat_bloc.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart'; // Import your modules

class AppointmentHistoryCardDoctor extends StatefulWidget {
  final AppointMentDetails appointment;

  const AppointmentHistoryCardDoctor({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<AppointmentHistoryCardDoctor> createState() =>
      _AppointmentHistoryCardDoctorState();
}

class _AppointmentHistoryCardDoctorState
    extends State<AppointmentHistoryCardDoctor> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final allDoctorData =
          BlocProvider.of<ListChatBloc>(context, listen: false);
      allDoctorData.add(setMessageCountUpdateDoctor(
          context: context, appointMentId: widget.appointment.id ?? ""));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    return BlocConsumer<ListChatBloc, ListChatState>(
        listener: (context, state) {
      if (state is listChatFailure) {
        showSnackBar(state.error, context);
      }
      if (state is setMessageCountUpdateDoctorSuccess) {}
    }, builder: (context, state) {
      if (state is listChatLoding) {
        return Loder();
      }
      return Scaffold(
          appBar: AppBar(),
          body: Card(
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
                  Text(
                      'Doctor ID: ${widget.appointment.doctorId ?? "Unknown"}'),
                  SizedBox(height: 8.0),
                  Text('AppointMent ID: ${widget.appointment.id ?? "Unknown"}'),
                  SizedBox(height: 8.0),
                  Text(
                      'Comments: ${widget.appointment.comments ?? "No comments"}'),
                  SizedBox(height: 8.0),
                  SizedBox(height: 8.0),
                  Text(
                      'Is Video Appointment: ${widget.appointment.isVedio ?? false}'),
                  SizedBox(height: 8.0),
                  Text(
                      'Is Complete: ${widget.appointment.isComplete ?? false}'),
                  SizedBox(height: 8.0),
                  if (widget.appointment.timeSlotPicks != null)
                    Text(
                        'Time Slot: ${widget.appointment.timeSlotPicks!.toJson()}'),
                  if (widget.appointment.rating != null)
                    RatingBar.builder(
                      initialRating: double.parse(widget.appointment.rating!),
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
                  double.parse(widget.appointment.rating!) <= 2
                      ? TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => MessageScreen(
                                    isSeen: false,
                                    appointMentId: widget.appointment.id ?? "",
                                    userId: widget.appointment.userId ?? "",
                                    isDoctor: true,
                                    doctorID:
                                        widget.appointment.doctorId ?? "")));
                          },
                          icon: Icon(Icons.message),
                          label: Text(
                              "Message ${state is setMessageCountUpdateDoctorSuccess ? state.messageCountSee : "0"}"))
                      : Container()
                ],
              ),
            ),
          ));
    });
  }
}
