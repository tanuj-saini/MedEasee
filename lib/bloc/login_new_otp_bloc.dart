import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:med_ease/bloc/authModel.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_new_otp_event.dart';
part 'login_new_otp_state.dart';

class LoginNewOtpBloc extends Bloc<LoginNewOtpEvent, LoginNewOtpState> {
  LoginNewOtpBloc() : super(LoginNewOtpInitial()) {
    String loginResults = '';
    AuthModel authModel = AuthModel();
    UserCredential? userCredential;
    on<sendOtpToPhoneEvent>((event, emit) async {
      emit(LoginScreenLodingState());
      try {
        await authModel.loginWithPhone(
            phoneNumber: event.phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) {
              add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
            },
            verificationFailed: (FirebaseAuthException e) {
              add(OnPhoneAuthErrorEvent(error: e.toString()));
            },
            codeSent: (String verificationId, int? refreshToken) {
              add(onPhoneOtpSend(
                  verificationId: verificationId, token: refreshToken));
            },
            codeAutoRetrievalTimeout: (String verificationId) {});
      } catch (e) {
        emit(LoginScreenErrorState(error: e.toString()));
      }
    });

    on<onPhoneOtpSend>((event, emit) async {
      emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
    });
    on<VerifySendOtp>((event, emit) async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otpCode);
        add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      } catch (e) {
        emit(LoginScreenErrorState(error: e.toString()));
      }
    });

    on<OnPhoneAuthErrorEvent>((event, emit) async {
      emit(LoginScreenErrorState(error: event.error));
    });
    on<OnPhoneAuthVerificationCompleteEvent>((event, emit) async {
      try {
        await authModel.authetication
            .signInWithCredential(event.credential)
            .then((value) => emit(SignUpScreenOtpSuccessState()));
        emit(LoginScreenLoadedState());
      } catch (e) {
        emit(LoginScreenErrorState(error: e.toString()));
      }
    });

    on<SignUpEventPhone>((event, emit) async {
      emit(SignUpLoding());
      try {
        http.Response res = await http.post(Uri.parse("$ip/SignUpUser"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"phoneNumber": event.phoneNumber}));
        _httpErrorHandle(res, emit, event.context);
        Map<String, dynamic> decodedJson = jsonDecode(res.body);

        UserModuleE userModule = UserModuleE.fromJson(decodedJson);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = jsonDecode(res.body)["token"];
        String typeOfUser = "user";
        print(token);
        await prefs.setString("x-auth-token-w", token);
        await prefs.setString("typeOfUser", typeOfUser);

        return emit(SignUpSuccess(userModule: userModule));
      } catch (e) {
        return emit(SignUpFailure(error: e.toString()));
      }
    });

    on<SignDoctorEvent>((event, emit) async {
      emit(SignUpLoding());
      try {
        http.Response res = await http.post(Uri.parse("$ip/SignUpDoctor"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({"phoneNumber": event.phoneNumber}));
        _httpErrorHandle(res, emit, event.context);
        final jsonData = jsonDecode(res.body);

        Doctor doctorModule = Doctor.fromJson(jsonData);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = jsonDecode(res.body)["token"];
        String typeOfUser = "doctor";
        print(token);
        await prefs.setString("x-auth-token-D", token);
        await prefs.setString("typeOfUser", typeOfUser);

        return emit(SignUpDoctorSucess(doctorModuleE: doctorModule));
      } catch (e) {
        return emit(SignUpFailure(error: e.toString()));
      }
    });
  }
}
