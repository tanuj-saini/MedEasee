part of 'login_new_otp_bloc.dart';

@immutable
sealed class LoginNewOtpState {}

final class LoginNewOtpInitial extends LoginNewOtpState {}

class LoginScreenLodingState extends LoginNewOtpState {}

class LoginScreenInitialState extends LoginNewOtpState {}

class LoginScreenLoadedState extends LoginNewOtpState {}

class LoginScreenErrorState extends LoginNewOtpState {
  final String error;

  LoginScreenErrorState({required this.error});
}

class PhoneAuthCodeSentSuccess extends LoginNewOtpState {
  final String verificationId;

  PhoneAuthCodeSentSuccess({required this.verificationId});
}

class SignUpScreenOtpSuccessState extends LoginNewOtpState {}

class SignUpSuccess extends LoginNewOtpState {
  final UserModuleE userModule;
  SignUpSuccess({required this.userModule});
}

class SignUpFailure extends LoginNewOtpState {
  final String error;
  SignUpFailure({required this.error});
}

class SignUpLoding extends LoginNewOtpState {}

class SignUpDoctorSucess extends LoginNewOtpState {
  final Doctor doctorModuleE;
  SignUpDoctorSucess({required this.doctorModuleE});
}

class PersistHttpError extends LoginNewOtpState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<LoginNewOtpState> emit,
    BuildContext context) {
  switch (response.statusCode) {
    case 200:
      break;
    case 400:
    case 500:
      emit(PersistHttpError(
          errorMessage: jsonDecode(response.body)["error"] ?? "Unknown Error"));
      showSnackBar(
          jsonDecode(response.body)["error"] ?? "Unknown Error", context);
      break;
    default:
      emit(PersistHttpError(errorMessage: "An unexpected error occurred"));
      showSnackBar("An unexpected error occurred", context);
  }
}
