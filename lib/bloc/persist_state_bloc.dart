import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/Utils/Colors.dart';

import 'package:med_ease/Utils/DoctorModule.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'persist_state_event.dart';
part 'persist_state_state.dart';

class PersistStateBloc extends Bloc<PersistStateEvent, PersistStateState> {
  PersistStateBloc() : super(PersistStateInitial()) {
    on<persistEvent>((event, emit) async {
      emit(PersistLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        UserModuleE userModule = UserModuleE(
            name: "",
            emailAddress: "",
            age: "",
            id: "",
            phoneNumber: "",
            homeAddress: "",
            appointment: [],
            medicalShopHistory: [],
            emergencyCall: [],
            appointMentHistory: []);
        String? token = prefs.getString('x-auth-token-w');
        if (token == null) {
          prefs.setString('x-auth-token-w', '');
        }
        var tokenRes = await http
            .post(Uri.parse('$ip/tokenIsValid'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token-w': token!,
        });
        _httpErrorHandle(tokenRes, emit, event.context);
        var response = jsonDecode(tokenRes.body);
        if (response == false) {
          return emit(PersitSuccess(
              userModule: userModule,
              isPersist: false,
              sugesstion: "No auth Token"));
        }
        if (response == true) {
          http.Response userRes =
              await http.get(Uri.parse('$ip/'), headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-w': token,
          });
          _httpErrorHandle(userRes, emit, event.context);
          Map<String, dynamic> decodedJson = jsonDecode(userRes.body);
          print(userRes.body);
          userModule = UserModuleE.fromJson(decodedJson);
          print("welcome again");

          return emit(PersitSuccess(
              sugesstion: "Welcome Again",
              userModule: userModule,
              isPersist: true));
        }
      } catch (e) {
        return emit(PersistError(error: e.toString()));
      }
    });

    on<persistDoctorEvent>((event, emit) async {
      emit(PersistLoading());
      try {
        print("hello");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Doctor doctor = Doctor(
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
            id: "",
            appointMentHistory: []);
        String? token = prefs.getString('x-auth-token-D');
        if (token == null) {
          prefs.setString('x-auth-token-D', '');
        }
        var tokenRes = await http.post(Uri.parse('$ip/tokenIsValid/doctor'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token-D': token!,
            });

        var response = jsonDecode(tokenRes.body);
        print(response);
        if (response == false) {
          print("false  noooo");
          return emit(PersitDoctorSuccess(
              isPersist: false,
              doctorModule: doctor,
              suggesstion: "No Auth Token"));
        }
        if (response == true) {
          http.Response userRes =
              await http.get(Uri.parse('$ip/D'), headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-D': token,
          });

          final jsonData = jsonDecode(userRes.body);
          print(userRes.body);
          doctor = Doctor.fromJson(jsonData);
          print("welcome again");
          return emit(PersitDoctorSuccess(
              isPersist: true,
              doctorModule: doctor,
              suggesstion: "Welcome again"));
        }
      } catch (e) {
        return emit(PersistError(error: e.toString()));
      }
    });
  }
}
