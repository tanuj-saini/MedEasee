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
  final String doctorId;
  final String userId;
  final bool isMe;

  MessageModule({
    required this.message,
    required this.doctorId,
    required this.userId,
    required this.isMe,
  });

  MessageModule copyWith({
    String? message,
    String? doctorId,
    String? userId,
    bool? isMe,
  }) {
    return MessageModule(
      message: message ?? this.message,
      doctorId: doctorId ?? this.doctorId,
      userId: userId ?? this.userId,
      isMe: isMe ?? this.isMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'doctorId': doctorId,
      'userId': userId,
      'isMe': isMe,
    };
  }

  factory MessageModule.fromMap(Map<String, dynamic> map) {
    return MessageModule(
      message: map['message'] as String,
      doctorId: map['doctorId'] as String,
      userId: map['userId'] as String,
      isMe: map['isMe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModule.fromJson(String source) =>
      MessageModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModule(message: $message, doctorId: $doctorId, userId: $userId, isMe: $isMe)';
  }

  @override
  bool operator ==(covariant MessageModule other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.doctorId == doctorId &&
        other.userId == userId &&
        other.isMe == isMe;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        doctorId.hashCode ^
        userId.hashCode ^
        isMe.hashCode;
  }
}
