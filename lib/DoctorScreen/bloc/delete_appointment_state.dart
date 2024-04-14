part of 'delete_appointment_bloc.dart';

@immutable
sealed class DeleteAppointmentState {}

final class DeleteAppointmentInitial extends DeleteAppointmentState {}

class DeleteAppointFailure extends DeleteAppointmentState {
  final String error;
  DeleteAppointFailure({required this.error});
}

class DeleteAppointLoding extends DeleteAppointmentState {}

class DeleteAppointSuccess extends DeleteAppointmentState {
  final String successText;
  DeleteAppointSuccess({required this.successText});
}
