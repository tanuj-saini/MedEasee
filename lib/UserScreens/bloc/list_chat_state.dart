part of 'list_chat_bloc.dart';

@immutable
sealed class ListChatState {}

final class ListChatInitial extends ListChatState {}

class listChatSuccess extends ListChatState {
  final ChatDetailed chatInfoList;
  listChatSuccess({required this.chatInfoList});
}

class listChatFailure extends ListChatState {
  final String error;
  listChatFailure({required this.error});
}

class listChatLoding extends ListChatState {}

class PersistHttpError extends ListChatState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}

void _httpErrorHandle(
    http.Response response, Emitter<ListChatState> emit, BuildContext context) {
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
