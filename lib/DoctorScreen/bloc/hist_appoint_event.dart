part of 'hist_appoint_bloc.dart';

@immutable
sealed class HistAppointEvent {}

class histAppointMentUserEvent extends HistAppointEvent {
  final String userId;
  final BuildContext context;

  histAppointMentUserEvent({required this.context, required this.userId});
}

class histAppointMentDoctorEvent extends HistAppointEvent {
  final String doctorId;
  final BuildContext context;

  histAppointMentDoctorEvent({required this.context, required this.doctorId});
}
