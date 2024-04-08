part of 'user_moduel_bloc.dart';

@immutable
sealed class UserModuelState {}

final class UserModuelInitial extends UserModuelState {}

class userModuleSuccess extends UserModuelState {
  final UserModule userModule;
  userModuleSuccess({required this.userModule});
}

class userModulefaliure extends UserModuelState {
  final String error;
  userModulefaliure({required this.error});
}

class doctorModuleSuccess extends UserModuelState {
  final Doctor doctorModule;
  doctorModuleSuccess({required this.doctorModule});
}

class userModuleLoding extends UserModuelState {}
