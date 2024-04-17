part of 'login_new_otp_bloc.dart';

@immutable
sealed class LoginNewOtpEvent {}

class sendOtpToPhoneEvent extends LoginNewOtpEvent {
  final String phoneNumber;
  sendOtpToPhoneEvent({required this.phoneNumber});
}

class onPhoneOtpSend extends LoginNewOtpEvent {
  final String verificationId;
  final int? token;

  onPhoneOtpSend({required this.verificationId, required this.token});
}

class VerifySendOtp extends LoginNewOtpEvent {
  final String otpCode;
  final String verificationId;

  VerifySendOtp({required this.otpCode, required this.verificationId});
}

class OnPhoneAuthErrorEvent extends LoginNewOtpEvent {
  final String error;

  OnPhoneAuthErrorEvent({required this.error});
}

class OnPhoneAuthVerificationCompleteEvent extends LoginNewOtpEvent {
  final AuthCredential credential;

  OnPhoneAuthVerificationCompleteEvent({required this.credential});
}

class SignUpEventPhone extends LoginNewOtpEvent {
  final String phoneNumber;
  final BuildContext context;
  SignUpEventPhone({required this.context, required this.phoneNumber});
}

class SignDoctorEvent extends LoginNewOtpEvent {
  final String phoneNumber;
  final BuildContext context;
  SignDoctorEvent({required this.context, required this.phoneNumber});
}
