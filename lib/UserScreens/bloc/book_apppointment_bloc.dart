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

part 'book_apppointment_event.dart';
part 'book_apppointment_state.dart';

class BookApppointmentBloc
    extends Bloc<BookApppointmentEvent, BookApppointmentState> {
  BookApppointmentBloc() : super(BookApppointmentInitial()) {
    on<BookAppointmentUserEvent>((event, emit) async {
      emit(BookApppointmentLoding());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token-w');
        if (token == null) {
          return emit(BookApppointmentFailure(error: "No Auth token"));
        }

        String doctorId = event.doctorId;
        http.Response res =
            await http.post(Uri.parse('$ip/bookAppointment?doctorId=$doctorId'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'x-auth-token-w': token,
                },
                body: jsonEncode({
                  'date': event.date,
                  'isComplete': event.isComplete,
                  'timeSlots': event.timeSlotPicks,
                  'isVedio': event.isVedio,
                }));
        _httpErrorHandle(res, emit, event.context);
        print(res.body);

        Map<String, dynamic> decodedJson = jsonDecode(res.body);
        print(decodedJson['user']);
        UserModuleE userModule = UserModuleE.fromJson(decodedJson['user']);

        print("yes");

        return emit(BookApppointmentSuccess(userModule: userModule));
      } catch (e) {
        return emit(BookApppointmentFailure(error: e.toString()));
      }
    });
  }
}
