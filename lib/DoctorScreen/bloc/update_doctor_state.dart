part of 'update_doctor_bloc.dart';

@immutable
sealed class UpdateDoctorState {}

final class UpdateDoctorInitial extends UpdateDoctorState {}

class updateDoctorSuccess extends UpdateDoctorState {}

class updateDoctorFailure extends UpdateDoctorState {
  final String error;
  updateDoctorFailure({required this.error});
}

class updateDoctorLoding extends UpdateDoctorState {}
