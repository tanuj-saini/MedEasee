part of 'otp_bloc_bloc.dart';

@immutable
sealed class OtpBlocState {}

final class OtpBlocInitial extends OtpBlocState {}

class OtpSuccess extends OtpBlocState {}

class OtpLoding extends OtpBlocState {}

class OtpFailure extends OtpBlocState {
  final String error;

  OtpFailure({required this.error});
}
