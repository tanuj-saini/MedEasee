import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Login_SignIn/OtpScreen.dart';
import 'package:meta/meta.dart';

part 'sendotp_bloc_event.dart';
part 'sendotp_bloc_state.dart';

class SendotpBlocBloc extends Bloc<SendotpBlocEvent, SendotpBlocState> {
  SendotpBlocBloc() : super(SendotpBlocInitial()) {
    on<SendPhoneNumber>((event, emit) async {
      emit(PhoneLoading());
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth
          .verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await firebaseAuth.signInWithCredential(credential);
          } catch (e) {
            if (!emit.isDone) {
              emit(PhoneFailure(error: e.toString()));
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!emit.isDone) {
            emit(PhoneFailure(error: e.message ?? "Verification failed"));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          print("yes");
          print(verificationId);
          print(resendToken);

          emit(PhoneVerificationID(verificationID: verificationId));
          // }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      )
          .catchError((error) {
        print(error);
        if (!emit.isDone) {
          return emit(PhoneFailure(error: error.toString()));
        }
      });
    });
  }
}
