import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/UserScreens/bloc/all_doctors_bloc.dart';
import 'package:med_ease/UserScreens/bloc/book_apppointment_bloc.dart';
import 'package:med_ease/UserScreens/utils/PaymentScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/DoctorModule.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/Utils/OrderSplashScreen.dart';
import 'package:med_ease/Utils/SplashScreen.dart';

class CardDoctorDetails extends StatefulWidget {
  final List<TimeSlots> timeSlotPicks;

  final Doctor doctorModule;
  CardDoctorDetails(
      {required this.timeSlotPicks, required this.doctorModule, super.key});
  @override
  State<StatefulWidget> createState() {
    return _CardDetailsScreeen();
  }
}

class _CardDetailsScreeen extends State<CardDoctorDetails> {
  @override
  Widget build(BuildContext context) {
    final bookAppointment = BlocProvider.of<BookApppointmentBloc>(context);
    String date = DateTime.now().toString();
    return BlocConsumer<BookApppointmentBloc, BookApppointmentState>(
      listener: (context, state) {
        if (state is BookApppointmentFailure) {
          showSnackBar(state.error, context);
        }
        if (state is BookApppointmentSuccess) {
          final UserBlocUpdate = context.read<UserBloc>();
          UserBlocUpdate.updateUser(state.userModule);

          showSnackBar("Book Complete", context);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => OrderSplash(
                  timeSlot: widget.timeSlotPicks[0],
                  AppointMentId: state.userModule.appointment.last.id ?? "",
                  dateTimeOrder: DateTime.now().toString())));
        }
      },
      builder: (context, state) {
        if (state is BookApppointmentLoding) {
          return Loder();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.doctorModule.name),
          ),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => PaymentScreen(
                              timeSlotPicks: [],
                              date: date,
                              doctorId: widget.doctorModule.id,
                              isComplete: false)));
                    },
                    child: Text("book")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      bookAppointment.add(BookAppointmentUserEvent(
                          timeSlotPicks: widget.timeSlotPicks,
                          date: date,
                          context: context,
                          doctorId: widget.doctorModule.id,
                          isComplete: false));
                    },
                    child: Text("Without Payment"))
              ],
            ),
          ),
        );
      },
    );
  }
}
