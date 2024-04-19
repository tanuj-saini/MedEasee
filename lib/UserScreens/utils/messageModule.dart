// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class messageList extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const messageList({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: MarkdownBody(
              selectable: true,
              data: text,
            ),
          ),
        ),
      ],
    );
  }
}

class MessageModule {
  final String message;
  final String currentId;
  final String reciverId;
  final bool isDoctor;
  final String time;

  MessageModule({
    required this.message,
    required this.currentId,
    required this.reciverId,
    required this.isDoctor,
    required this.time,
  });

  MessageModule copyWith({
    String? message,
    String? currentId,
    String? reciverId,
    bool? isDoctor,
    String? time,
  }) {
    return MessageModule(
      message: message ?? this.message,
      currentId: currentId ?? this.currentId,
      reciverId: reciverId ?? this.reciverId,
      isDoctor: isDoctor ?? this.isDoctor,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'currentId': currentId,
      'reciverId': reciverId,
      'isDoctor': isDoctor,
      'time': time,
    };
  }

  factory MessageModule.fromMap(Map<String, dynamic> map) {
    return MessageModule(
      message: map['message'] as String,
      currentId: map['currentId'] as String,
      reciverId: map['reciverId'] as String,
      isDoctor: map['isDoctor'] as bool,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModule.fromJson(String source) =>
      MessageModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModule(message: $message, currentId: $currentId, reciverId: $reciverId, isDoctor: $isDoctor, time: $time)';
  }

  @override
  bool operator ==(covariant MessageModule other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.currentId == currentId &&
        other.reciverId == reciverId &&
        other.isDoctor == isDoctor &&
        other.time == time;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        currentId.hashCode ^
        reciverId.hashCode ^
        isDoctor.hashCode ^
        time.hashCode;
  }
}
