import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/DoctorModule.dart';
import 'package:med_ease/Modules/UserModule.dart';
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
        String? token = prefs.getString('x-auth-token-w');
        if (token == null) {
          prefs.setString('x-auth-token-w', '');
        }
        var tokenRes = await http
            .post(Uri.parse('$ip/tokenIsValid'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token-w': token!,
        });

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

          final userData =
              UserModule.fromJson(jsonEncode(jsonDecode(userRes.body)));
          print("welcome again");
          print(userData);
          return emit(PersitSuccess(
              sugesstion: "Welcome Again",
              userModule: userData,
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
              doctorModule: doctorModule,
              suggesstion: "No Auth Token"));
        }
        if (response == true) {
          http.Response userRes =
              await http.get(Uri.parse('$ip/D'), headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-D': token,
          });
          print(userRes.body);

          final userData =
              DoctorModuleE.fromJson(jsonEncode(jsonDecode(userRes.body)));

          print("welcome again");
          //print(userData);
          return emit(PersitDoctorSuccess(
              isPersist: true,
              doctorModule: userData,
              suggesstion: "Welcome again"));
        }
      } catch (e) {
        return emit(PersistError(error: e.toString()));
      }
    });
  }
}
