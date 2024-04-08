import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'all_doctors_event.dart';
part 'all_doctors_state.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvent, AllDoctorsState> {
  AllDoctorsBloc() : super(AllDoctorsInitial()) {
    on<AllDoctorsDataEvent>((event, emit) async {
      emit(AllDoctorsDataLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-w');
        if (token == null) {
          return emit(AllDoctorsDataFailure(error: "No Auth token"));
        }
        final String searchh = event.search;
        print(searchh);
        http.Response res = await http.post(
            Uri.parse("$ip/User/SearchDoctor/ $searchh"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token-w': token,
            });
        print(res.body);
        List<DoctorModuleE> allDoctors = [];
        httpErrorHandle(
            response: res,
            context: event.context,
            onSuccess: () async {
              List<dynamic> jsonResponse = jsonDecode(res.body);

              // Calculate the length of the list
              int length = jsonResponse.length;
              print(length);

              for (int i = 0; i < length; i++) {
                // Assuming DoctorModuleE has a factory constructor named fromJson
                allDoctors
                    .add(DoctorModuleE.fromJson(jsonEncode(jsonResponse[i])));
              }
            });

        print(allDoctors);
        return emit(AllDoctorsDataSuccess(allDoctorsData: allDoctors));
      } catch (e) {
        return emit(AllDoctorsDataFailure(error: e.toString()));
      }
    });
  }
}
