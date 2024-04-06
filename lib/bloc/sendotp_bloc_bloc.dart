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
            if (!emit.isDone) {}
          } catch (e) {
            if (!emit.isDone) {
              return emit(PhoneFailure(error: e.toString()));
            }
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!emit.isDone) {
            return emit(
                PhoneFailure(error: e.message ?? "Verification failed"));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!emit.isDone) {
            print("yes");
            emit(PhoneVerificationID(verificationID: verificationId));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      )
          .catchError((error) {
        if (!emit.isDone) {
          return emit(PhoneFailure(error: error.toString()));
        }
      });
    });
  }
}


// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:med_ease/Login_SignIn/OtpScreen.dart';
// import 'package:meta/meta.dart';

// part 'sendotp_bloc_event.dart';
// part 'sendotp_bloc_state.dart';

// class SendotpBlocBloc extends Bloc<SendotpBlocEvent, SendotpBlocState> {
//   SendotpBlocBloc() : super(SendotpBlocInitial()) {
//     on<SendPhoneNumber>((event, emit) async {
//       emit(PhoneLoading());
//       try {
//         FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//         await firebaseAuth.verifyPhoneNumber(
//           phoneNumber: event.phoneNumber,
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await firebaseAuth.signInWithCredential(credential);
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             return emit(
//                 PhoneFailure(error: e.message ?? "Verification failed"));
//           },
//           codeSent: (String verificationId, int? resendToken) {
//             return emit(PhoneVerificationID(verificationID: verificationId));
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {},
//         );
//         return emit(PhoneSuccess());
//       } on FirebaseAuthException catch (e) {
//         emit(PhoneFailure(error: e.toString()));
//       }
//     });
//   }
// }

// class SendotpBlocBloc extends Bloc<SendotpBlocEvent, SendotpBlocState> {
//   SendotpBlocBloc() : super(SendotpBlocInitial());

//   @override
//   Stream<SendotpBlocState> mapEventToState(SendotpBlocEvent event) async* {
//     if (event is SendPhoneNumber) {
//       yield* _mapSendPhoneNumberToState(event);
//     }
//   }

//   Stream<SendotpBlocState> _mapSendPhoneNumberToState(
//       SendPhoneNumber event) async* {
//     yield PhoneLoading();
//     try {
//       FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//       await firebaseAuth.verifyPhoneNumber(
//         phoneNumber: event.phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await firebaseAuth.signInWithCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) async* {
//           yield PhoneFailure(error: e.message ?? "Verification failed");
//         },
//         codeSent: (String verificationId, int? resendToken) async* {
//           yield PhoneVerificationID(verificationID: verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       yield PhoneFailure(error: e.toString());
//     }
//   }
// }
