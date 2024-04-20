part of 'refresh_doctor_bloc.dart';

@immutable
sealed class RefreshDoctorEvent {}

class RefreshDoctorListEvent extends RefreshDoctorEvent {
  final String doctorId;
  final BuildContext context;
  RefreshDoctorListEvent({required this.context, required this.doctorId});
}

class deleteAppointEvent extends RefreshDoctorEvent {
  final String doctorId;
  final String userId;
  final String appointMentId;
  final BuildContext context;
  deleteAppointEvent({
    required this.appointMentId,
    required this.context,
    required this.doctorId,
    required this.userId,
  });
}

class updateIsCompleteEvent extends RefreshDoctorEvent {
  final String appointMentId;
  final String doctorId;
  final String userId;
  final BuildContext context;

  updateIsCompleteEvent(
      {required this.appointMentId,
      required this.context,
      required this.doctorId,
      required this.userId});
}

class updateRatingCompleted extends RefreshDoctorEvent {
  final String doctorId;
  final String userId;
  final String appointMentId;
  final String comments;
  final String rating;
  final BuildContext context;

  updateRatingCompleted(
      {required this.context,
      required this.doctorId,
      required this.userId,
      required this.appointMentId,
      required this.comments,
      required this.rating});
}
