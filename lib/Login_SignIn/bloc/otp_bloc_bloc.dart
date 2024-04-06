import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'otp_bloc_event.dart';
part 'otp_bloc_state.dart';

class OtpBlocBloc extends Bloc<OtpBlocEvent, OtpBlocState> {
  OtpBlocBloc() : super(OtpBlocInitial()) {
    on<OtpBlocevent>((event, emit) async {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      emit(OtpLoding());
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationID, smsCode: event.UserOtp);
        await firebaseAuth.signInWithCredential(credential);
        emit(OtpSuccess());
      } on FirebaseAuthException catch (e) {
        emit(OtpFailure(error: e.toString()));
      }
    });
  }
}
