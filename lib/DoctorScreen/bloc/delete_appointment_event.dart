part of 'delete_appointment_bloc.dart';

@immutable
sealed class DeleteAppointmentEvent {}

class deleteAppoint extends DeleteAppointmentEvent {
  final String appointMentId;
  final String doctorId;
  final String userId;
  deleteAppoint(
      {required this.doctorId,
      required this.userId,
      required this.appointMentId});
}
