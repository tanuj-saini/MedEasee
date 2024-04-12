part of 'user_moduel_bloc.dart';

@immutable
sealed class UserModuelState {}

final class UserModuelInitial extends UserModuelState {}

class userModuleSuccess extends UserModuelState {
  final UserModuleE userModule;
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

class PersistHttpError extends UserModuelState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<UserModuelState> emit,
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
