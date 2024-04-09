import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';

import 'package:med_ease/Utils/DoctorModule.dart';

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
        UserModuleE userModule = UserModuleE(
            name: event.name,
            emailAddress: event.emailAddress,
            age: event.age,
            id: "",
            phoneNumber: event.phoneNumber,
            homeAddress: event.homeAddress,
            appointments: [],
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
              Map<String, dynamic> decodedJson = jsonDecode(res.body);

              userModule = UserModuleE.fromJson(decodedJson);
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
        Doctor doctorModule = Doctor(
            name: event.name,
            bio: event.bio,
            phoneNumber: event.phoneNumber,
            specialist: event.specialist,
            currentWorkingHospital: event.currentWorkingHospital,
            profilePic: event.profilePic,
            registerNumbers: event.profilePic,
            experience: event.experience,
            emailAddress: event.emailAddress,
            age: event.age,
            applicationLeft: [],
            timeSlot: [],
            id: "");

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
              final jsonData = jsonDecode(res.body);

              doctorModule = Doctor.fromJson(jsonData);

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
