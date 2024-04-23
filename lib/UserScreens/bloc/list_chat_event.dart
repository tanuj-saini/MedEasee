part of 'list_chat_bloc.dart';

@immutable
sealed class ListChatEvent {}

class listChatEvents extends ListChatEvent {
  final BuildContext context;
  final bool isDoctor;
  final String currentId;
  final String reciverId;
  final String appointMentId;

  listChatEvents(
      {required this.currentId,
      required this.appointMentId,
      required this.isDoctor,
      required this.reciverId,
      required this.context});
}
