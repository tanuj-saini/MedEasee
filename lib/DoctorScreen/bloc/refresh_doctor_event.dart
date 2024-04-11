part of 'refresh_doctor_bloc.dart';

@immutable
sealed class RefreshDoctorEvent {}

class RefreshDoctorListEvent extends RefreshDoctorEvent {
  final String doctorId;
  final BuildContext context;
  RefreshDoctorListEvent({required this.context, required this.doctorId});
}
