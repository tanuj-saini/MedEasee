part of 'hist_appoint_bloc.dart';

@immutable
sealed class HistAppointState {}

final class HistAppointInitial extends HistAppointState {}
class HistAppointLoding extends HistAppointState{

}
class HistAppointUserSuccess extends HistAppointState{
  final UserModuleE user;


  HistAppointUserSuccess({required this.user});

}
class HistAppointDoctorSuccess extends HistAppointState{
  final Doctor doctor;


  HistAppointDoctorSuccess({required this.doctor});
  

}
class HistAppointError extends HistAppointState{
  final String error;


  HistAppointError({required this.error});
  
}


class PersistHttpError extends HistAppointState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<HistAppointState> emit,
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
