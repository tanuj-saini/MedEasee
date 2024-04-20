part of 'refresh_doctor_bloc.dart';

@immutable
sealed class RefreshDoctorState {}

final class RefreshDoctorInitial extends RefreshDoctorState {}

class RefreshDoctorSuccess extends RefreshDoctorState {
  final Doctor doctor;

  RefreshDoctorSuccess({required this.doctor});
}

class updateIsCompleteSuccess extends RefreshDoctorState {
  final Doctor doctor;
  final String userId;
  final String successText;

  updateIsCompleteSuccess(
      {required this.userId, required this.successText, required this.doctor});
}

class RefreshDoctorFailure extends RefreshDoctorState {
  final String error;

  RefreshDoctorFailure({required this.error});
}

class RefreshDoctorLoding extends RefreshDoctorState {}

class PersistHttpError extends RefreshDoctorState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

class DeleteAppointSuccess extends RefreshDoctorState {
  final String successText;
  final UserModuleE user;
  DeleteAppointSuccess({required this.user, required this.successText});
}

void _httpErrorHandle(http.Response response, Emitter<RefreshDoctorState> emit,
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
