part of 'appointmnet_bloc.dart';

@immutable
sealed class AppointmnetState {}

final class AppointmnetInitial extends AppointmnetState {}

class AppointmentSuccess extends AppointmnetState {
  final Doctor doctorModule;

  AppointmentSuccess({required this.doctorModule});
}

class AppointmentFailure extends AppointmnetState {
  final String error;
  AppointmentFailure({required this.error});
}

class AppointmentLoding extends AppointmnetState {}
