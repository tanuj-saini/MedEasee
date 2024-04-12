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

class PersistHttpError extends AllDoctorsState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<AllDoctorsState> emit,
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
