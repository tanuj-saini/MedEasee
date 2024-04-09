part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final UserModuleE userModule;
  SignUpSuccess({required this.userModule});
}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure({required this.error});
}

class SignUpLoding extends SignUpState {}

class SignUpDoctorSucess extends SignUpState {
  final Doctor doctorModuleE;
  SignUpDoctorSucess({required this.doctorModuleE});
}
