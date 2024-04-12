part of 'sendotp_bloc_bloc.dart';

@immutable
abstract class SendotpBlocState {}

class SendotpBlocInitial extends SendotpBlocState {}

class PhoneLoading extends SendotpBlocState {}

class PhoneSuccess extends SendotpBlocState {}

class PhoneVerificationID extends SendotpBlocState {
  final String verificationID;
  PhoneVerificationID({required this.verificationID});
}

class PhoneFailure extends SendotpBlocState {
  final String error;

  PhoneFailure({required this.error});
}

class PersistHttpError extends SendotpBlocState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(http.Response response, Emitter<SendotpBlocState> emit,
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
