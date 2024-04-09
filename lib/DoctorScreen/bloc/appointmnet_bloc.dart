import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/ApointmentModifyModule.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Utils/DoctorModule.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:med_ease/Utils/timeSlot.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'appointmnet_event.dart';
part 'appointmnet_state.dart';

class AppointmnetBloc extends Bloc<AppointmnetEvent, AppointmnetState> {
  AppointmnetBloc() : super(AppointmnetInitial()) {
    on<AppointMentDetailsEvent>((event, emit) async {
      emit(AppointmentLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(AppointmentFailure(error: "You are not a doctor"));
        }
        AppointmentModule appointmentModule = AppointmentModule(
            title: event.title,
            price: event.price,
            timeSlots: event.timeSlots,
            date: DateTime.now().toIso8601String());

        http.Response res = await http.post(Uri.parse("$ip/AppointmentModify"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token-D': token,
            },
            body: appointmentModule.toJson());

        Doctor doctorModule = Doctor(
            name: "",
            bio: "",
            phoneNumber: "",
            specialist: "",
            currentWorkingHospital: "",
            profilePic: "",
            registerNumbers: "",
            experience: "",
            emailAddress: "",
            age: "",
            applicationLeft: [],
            timeSlot: [],
            id: "");
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              final jsonData = jsonDecode(res.body);

              final doctorModule = Doctor.fromJson(jsonData);
              print('yes it works');
              print(doctorModule);
            });
        print(res.body);
        print("hello");
        print(doctorModule);
        return emit(AppointmentSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(AppointmentFailure(error: e.toString()));
      }
    });
  }
}
