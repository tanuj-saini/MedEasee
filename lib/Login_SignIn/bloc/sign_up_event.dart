part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpEventPhone extends SignUpEvent {
  final String phoneNumber;
  final BuildContext context;
  SignUpEventPhone({required this.context, required this.phoneNumber});
}

class SignDoctorEvent extends SignUpEvent {
  final String phoneNumber;
  final BuildContext context;
  SignDoctorEvent({required this.context, required this.phoneNumber});
}
