part of 'delete_appointment_bloc.dart';

@immutable
sealed class DeleteAppointmentEvent {}

class deleteAppoint extends DeleteAppointmentEvent {
  final String appointMentId;
  deleteAppoint({required this.appointMentId});
}
