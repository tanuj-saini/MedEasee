part of 'all_doctors_bloc.dart';

@immutable
sealed class AllDoctorsState {}

final class AllDoctorsInitial extends AllDoctorsState {}

class AllDoctorsDataFailure extends AllDoctorsState {
  final String error;
  AllDoctorsDataFailure({required this.error});
}

class AllDoctorsDataSuccess extends AllDoctorsState {
  final List<Doctor> allDoctorsData;
  AllDoctorsDataSuccess({required this.allDoctorsData});
}

class AllDoctorsDataLoding extends AllDoctorsState {}
