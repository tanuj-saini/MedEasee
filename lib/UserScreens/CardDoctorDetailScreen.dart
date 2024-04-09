import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/bloc/all_doctors_bloc.dart';
import 'package:med_ease/UserScreens/bloc/book_apppointment_bloc.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/DoctorModule.dart';
import 'package:med_ease/Utils/LoderScreen.dart';

class CardDoctorDetails extends StatefulWidget {
  final Doctor doctorModule;
  CardDoctorDetails({required this.doctorModule, super.key});
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
                      bookAppointment.add(BookAppointmentUserEvent(
                          context: context,
                          date: date,
                          doctorId: widget.doctorModule.id,
                          isComplete: false));
                    },
                    child: Text("book"))
              ],
            ),
          ),
        );
      },
    );
  }
}
