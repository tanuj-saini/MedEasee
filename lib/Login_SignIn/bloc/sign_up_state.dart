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

class PersistHttpError extends SignUpState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(
    http.Response response, Emitter<SignUpState> emit, BuildContext context) {
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
