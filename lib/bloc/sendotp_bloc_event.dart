part of 'sendotp_bloc_bloc.dart';

@immutable
sealed class SendotpBlocEvent {}

class PhoneNumber extends SendotpBlocEvent{
  final String phoneNumber;
  PhoneNumber({required this.phoneNumber});
  
}
