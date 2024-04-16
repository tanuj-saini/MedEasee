import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/ApointmentModifyModule.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UserScreens/utils/SelectedTimeSlot.dart';
import 'package:med_ease/Utils/Colors.dart';
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
            isVedio: event.isVedio,
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
        print(res.body);
        _httpErrorHandle(res, emit, event.context);

        final jsonData = jsonDecode(res.body);

        Doctor doctorModule = Doctor.fromJson(jsonData);
        print('yes it works');
        //print(doctorModule);
        return emit(AppointmentSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(AppointmentFailure(error: e.toString()));
      }
    });

    on<AppointMentRefresh>((event, emit) async {
      emit(AppointmentLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(AppointmentFailure(error: "You are not a doctor"));
        }
        String doctorId = event.doctorId;

        http.Response res = await http.get(
          Uri.parse(
              "$ip/getDoctorData?doctorId=$doctorId"), //getDoctorData:doctorId
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-D': token,
          },
        );
        _httpErrorHandle(res, emit, event.context);

        final jsonData = jsonDecode(res.body);

        Doctor doctorModule = Doctor.fromJson(jsonData);

        print(doctorModule);
        return emit(AppointmentSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(AppointmentFailure(error: e.toString()));
      }
    });

    on<AppointMentSelectedTimeSlot>((event, emit) async {
      emit(AppointmentLoding());
      try {
        String doctorId = event.doctorId;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(AppointmentFailure(error: "You are not a doctor"));
        }
        SelectedTimeSlotU selectedTimeSlot = SelectedTimeSlotU(
            price: event.price,
            title: event.title,
            isVedio: event.isVedio,
            date: DateTime.now().toString(),
            timeSlots: event.timeSlots);

        print('length');
        print(event.timeSlots.length);

        http.Response res = await http.post(
            Uri.parse('$ip/selectedTimeSlot?doctorId=$doctorId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token-D': token,
            },
            body: selectedTimeSlot.toJson());
        _httpErrorHandle(res, emit, event.context);
        print(res.body);
        final jsonData = jsonDecode(res.body);

        Doctor doctorModule = Doctor.fromJson(jsonData);
        print('yes it works');

        return emit(AppointmentSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(AppointmentFailure(error: e.toString()));
      }
    });

    on<AppointmentUpdateEvent>((event, emit) async {
      emit(AppointmentLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(AppointmentFailure(error: "You are not a doctor"));
        }
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
        SelectedTimeSlotU selectedTimeSlotU = SelectedTimeSlotU(
            price: event.price,
            title: event.title,
            isVedio: event.isVedio,
            date: event.date,
            timeSlots: event.timeSlots);
        http.Response res =
            await http.post(Uri.parse('$ip/AppointmentModifyUpdate'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token-D': token,
                },
                body: selectedTimeSlotU.toJson());
        _httpErrorHandle(res, emit, event.context);
        final jsonData = jsonDecode(res.body);

        doctorModule = Doctor.fromJson(jsonData);
        print('yes it works');
        print(doctorModule);

        return emit(AppointmentSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(AppointmentFailure(error: e.toString()));
      }
    });
  }
}
