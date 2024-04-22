import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'refresh_doctor_event.dart';
part 'refresh_doctor_state.dart';

class RefreshDoctorBloc extends Bloc<RefreshDoctorEvent, RefreshDoctorState> {
  RefreshDoctorBloc() : super(RefreshDoctorInitial()) {
    on<RefreshDoctorListEvent>((event, emit) async {
      emit(RefreshDoctorLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(RefreshDoctorFailure(error: "You are not a doctor"));
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
        print('yes it works');
        Doctor doctorModule = Doctor.fromJson(jsonData);

        print(doctorModule);
        return emit(RefreshDoctorSuccess(doctor: doctorModule));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });
    on<deleteAppointEvent>((event, emit) async {
      emit(RefreshDoctorLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(RefreshDoctorFailure(error: "You are not a doctor"));
        }

        http.Response res =
            await http.delete(Uri.parse("$ip/delete/AppointMents"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token-D': token,
                },
                body: jsonEncode({
                  "doctorId": event.doctorId,
                  "userId": event.userId,
                  "appointMentId": event.appointMentId
                }));
        _httpErrorHandle(res, emit, event.context);

        final jsonData = jsonDecode(res.body);

        Doctor doctorModule = Doctor.fromJson(jsonData['doctor']);
        return emit(RefreshDoctorSuccess(doctor: doctorModule));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });
    on<deleteAppointEventUser>((event, emit) async {
      emit(RefreshDoctorLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          return emit(RefreshDoctorFailure(error: "You are not a doctor"));
        }

        http.Response res =
            await http.delete(Uri.parse("$ip/delete/AppointMents/user"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token-D': token,
                },
                body: jsonEncode({
                  "doctorId": event.doctorId,
                  "userId": event.userId,
                  "appointMentId": event.appointMentId
                }));
        _httpErrorHandle(res, emit, event.context);
        Map<String, dynamic> decodedJson = jsonDecode(res.body);

        UserModuleE userModule = UserModuleE.fromJson(decodedJson['user']);

        return emit(DeleteAppointSuccess(
            user: userModule, successText: "AppointMents Delted"));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });
    on<updateIsCompleteEvent>((event, emit) async {
      emit(RefreshDoctorLoding());
      try {
        http.Response res =
            await http.post(Uri.parse("$ip/updateIsComplete/appointMent"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                  "doctorId": event.doctorId,
                  "userId": event.userId,
                  "appointMentId": event.appointMentId,
                }));
        _httpErrorHandle(res, emit, event.context);
        final jsonData = jsonDecode(res.body);
        Doctor doctorModule = Doctor.fromJson(jsonData);

        return emit(updateIsCompleteSuccess(
            successText: "Congragulation AppointMent Completed",
            doctor: doctorModule));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });

    on<updateRatingCompleted>((event, emit) async {
      emit(RefreshDoctorLoding());
      try {
        http.Response res = await http.post(
          Uri.parse("$ip/updateRatingAndComments/appointMent"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "doctorId": event.doctorId,
            "userId": event.userId,
            "appointMentId": event.appointMentId,
            "comments": event.comments,
            "rating": event.rating
          }),
        );
        _httpErrorHandle(res, emit, event.context);
        Map<String, dynamic> decodedJson = jsonDecode(res.body);

        UserModuleE userModule = UserModuleE.fromJson(decodedJson);

        return emit(updateCommetsRatingSucess(
            user: userModule, successText: "Thanks For Review"));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });
  }
}
