part of 'book_apppointment_bloc.dart';

@immutable
sealed class BookApppointmentState {}

final class BookApppointmentInitial extends BookApppointmentState {}

class BookApppointmentFailure extends BookApppointmentState {
  final String error;
  BookApppointmentFailure({required this.error});
}

class BookApppointmentSuccess extends BookApppointmentState {
  final UserModuleE userModule;

  BookApppointmentSuccess({required this.userModule});
}

class BookApppointmentLoding extends BookApppointmentState {}

class PersistHttpError extends BookApppointmentState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response,
    Emitter<BookApppointmentState> emit, BuildContext context) {
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
