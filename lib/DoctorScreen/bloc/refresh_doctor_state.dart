part of 'refresh_doctor_bloc.dart';

@immutable
sealed class RefreshDoctorState {}

final class RefreshDoctorInitial extends RefreshDoctorState {}

class RefreshDoctorSuccess extends RefreshDoctorState {
  final Doctor doctor;

  RefreshDoctorSuccess({required this.doctor});
}

class RefreshDoctorFailure extends RefreshDoctorState {
  final String error;

  RefreshDoctorFailure({required this.error});
}

class RefreshDoctorLoding extends RefreshDoctorState {}
