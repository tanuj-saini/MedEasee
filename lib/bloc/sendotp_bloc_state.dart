part of 'sendotp_bloc_bloc.dart';

@immutable
abstract class SendotpBlocState {}

class SendotpBlocInitial extends SendotpBlocState {}

class PhoneLoading extends SendotpBlocState {}

class PhoneSuccess extends SendotpBlocState {}

class PhoneVerificationID extends SendotpBlocState {
  final String verificationID;
  PhoneVerificationID({required this.verificationID});
}

class PhoneFailure extends SendotpBlocState {
  final String error;

  PhoneFailure({required this.error});
}
