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

class setZeroChat extends ListChatEvent {
  final BuildContext context;
  final String appointMentId;
  final bool isDoctor;

  setZeroChat(
      {required this.context,
      required this.appointMentId,
      required this.isDoctor});
}

class setMessageCountUpdateUser extends ListChatEvent {
  final BuildContext context;
  final String appointMentId;

  setMessageCountUpdateUser(
      {required this.context, required this.appointMentId});
}

class setMessageCountUpdateDoctor extends ListChatEvent {
  final BuildContext context;
  final String appointMentId;

  setMessageCountUpdateDoctor(
      {required this.context, required this.appointMentId});
}
