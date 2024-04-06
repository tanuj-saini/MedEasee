import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:med_ease/Modules/DoctorModule.dart';
import 'package:med_ease/Modules/UserModule.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'user_moduel_event.dart';
part 'user_moduel_state.dart';

class UserModuelBloc extends Bloc<UserModuelEvent, UserModuelState> {
  UserModuelBloc() : super(UserModuelInitial()) {
    on<userModuleEvent>((event, emit) async {
      emit(userModuleLoding());
      try {
        UserModule userModule = UserModule(
            name: event.name,
            emailAddress: event.emailAddress,
            age: event.age,
            id: "",
            phoneNumber: event.phoneNumber,
            homeAddress: event.homeAddress,
            appointment: [],
            medicalShopHistory: [],
            emergencyCall: []);
        http.Response res = await http.post(Uri.parse("$ip/user/signUp"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: userModule.toJson());
        print(res.body);
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              UserModule userModule =
                  UserModule.fromJson(jsonEncode(jsonDecode(res.body)));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = jsonDecode(res.body)["token"];
              String typeOfUser = "user";
              print(token);
              await prefs.setString("x-auth-token-w", token);
              await prefs.setString("typeOfUser", typeOfUser);
            });
        return emit(userModuleSuccess(userModule: userModule));
      } catch (e) {
        return emit(userModulefaliure(error: e.toString()));
      }
    });

    on<doctorModuleEvent>((event, emit) async {
      emit(userModuleLoding());
      try {
        DoctorModule doctorModule = DoctorModule(
            event.name,
            event.bio,
            event.phoneNumber,
            event.specialist,
            event.currentWorkingHospital,
            event.profilePic,
            event.registerNumbers,
            event.experience,
            event.emailAddress,
            event.age,
            [],
            [],
            "",
            "");
        http.Response res = await http.post(Uri.parse("$ip/doctor/signUp"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: doctorModule.toJson());
        print(res.body);
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              doctorModule =
                  DoctorModule.fromJson(jsonEncode(jsonDecode(res.body)));

              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = jsonDecode(res.body)["token"];
              String typeOfUser = "doctor";
              print(token);
              await prefs.setString("x-auth-token-D", token);
              await prefs.setString("typeOfUser", typeOfUser);
            });
        return emit(doctorModuleSuccess(doctorModule: doctorModule));
      } catch (e) {
        return emit(userModulefaliure(error: e.toString()));
      }
    });
  }
}
