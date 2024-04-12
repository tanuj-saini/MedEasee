part of 'persist_state_bloc.dart';

@immutable
sealed class PersistStateEvent {}

class persistEvent extends PersistStateEvent {
  final BuildContext context;

  persistEvent({required this.context});
}

class persistDoctorEvent extends PersistStateEvent {
  final BuildContext context;

  persistDoctorEvent({required this.context});
}

void _httpErrorHandle(http.Response response, Emitter<PersistStateState> emit,
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
