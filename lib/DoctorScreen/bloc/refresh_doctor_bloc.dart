import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/testModule.dart';
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
        doctorModule = Doctor.fromJson(jsonData);

        print(doctorModule);
        return emit(RefreshDoctorSuccess(doctor: doctorModule));
      } catch (e) {
        return emit(RefreshDoctorFailure(error: e.toString()));
      }
    });
  }
}
