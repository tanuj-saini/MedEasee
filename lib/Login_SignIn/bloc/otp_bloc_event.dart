part of 'otp_bloc_bloc.dart';

@immutable
sealed class OtpBlocEvent {}

class OtpBlocevent extends OtpBlocEvent {
  final String verificationID;
  final String UserOtp;
  OtpBlocevent({required this.UserOtp, required this.verificationID});
}
