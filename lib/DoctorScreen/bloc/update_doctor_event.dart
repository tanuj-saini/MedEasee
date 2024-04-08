part of 'update_doctor_bloc.dart';

@immutable
sealed class UpdateDoctorEvent {}

class UpdateModifyDoctorEvent extends UpdateDoctorEvent {}
