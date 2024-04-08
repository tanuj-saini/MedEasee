import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/DoctorModule.dart';
import 'package:med_ease/Modules/UserModule.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEventPhone>((event, emit) async {
      emit(SignUpLoding());
      try {
        UserModule userModule = UserModule(
            name: "",
            emailAddress: "",
            age: "",
            id: "",
            phoneNumber: "",
            homeAddress: "",
            appointment: [],
            medicalShopHistory: [],
            emergencyCall: []);
        http.Response res = await http.post(Uri.parse("$ip/SignUpUser"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"phoneNumber": event.phoneNumber}));
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              final userModule =
                  UserModule.fromJson(jsonEncode(jsonDecode(res.body)));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = jsonDecode(res.body)["token"];
              String typeOfUser = "user";
              print(token);
              await prefs.setString("x-auth-token-w", token);
              await prefs.setString("typeOfUser", typeOfUser);
            });
        return emit(SignUpSuccess(userModule: userModule));
      } catch (e) {
        return emit(SignUpFailure(error: e.toString()));
      }
    });

    on<SignDoctorEvent>((event, emit) async {
      emit(SignUpLoding());
      try {
        DoctorModuleE doctorModule = DoctorModuleE(
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
        http.Response res = await http.post(Uri.parse("$ip/SignUpDoctor"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"phoneNumber": event.phoneNumber}));
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              doctorModule =
                  DoctorModuleE.fromJson(jsonEncode(jsonDecode(res.body)));

              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = jsonDecode(res.body)["token"];
              String typeOfUser = "doctor";
              print(token);
              await prefs.setString("x-auth-token-D", token);
              await prefs.setString("typeOfUser", typeOfUser);
            });
        return emit(SignUpDoctorSucess(doctorModuleE: doctorModule));
      } catch (e) {
        return emit(SignUpFailure(error: e.toString()));
      }
    });
  }
}
