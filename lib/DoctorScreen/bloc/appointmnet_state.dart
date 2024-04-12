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

class PersistHttpError extends AppointmnetState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<AppointmnetState> emit,
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
