import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'hist_appoint_event.dart';
part 'hist_appoint_state.dart';

class HistAppointBloc extends Bloc<HistAppointEvent, HistAppointState> {
  HistAppointBloc() : super(HistAppointInitial()) {
    on<histAppointMentUserEvent>((event, emit) async {
      emit(HistAppointLoding());
      try {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // String? token = prefs.getString('x-auth-token-w');
        // if (token == null) {
        //   return emit(HistAppointError(error: "You are not a User"));
        // }
        http.Response res =
            await http.post(Uri.parse("$ip/get/AppointMent/History"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({"userId": event.userId}));
        _httpErrorHandle(res, emit, event.context);
        Map<String, dynamic> decodedJson = jsonDecode(res.body);

        UserModuleE userModule = UserModuleE.fromJson(decodedJson);
      } catch (e) {
        return emit(HistAppointError(error: e.toString()));
      }
    });

    on<histAppointMentDoctorEvent>((event, emit) async {
      emit(HistAppointLoding());
      try {
        http.Response res = await http.post(Uri.parse(""),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"userId": event.doctorId}));
        _httpErrorHandle(res, emit, event.context);
      } catch (e) {
        return emit(HistAppointError(error: e.toString()));
      }
    });
  }
}
