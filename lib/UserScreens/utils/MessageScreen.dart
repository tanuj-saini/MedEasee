import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/utils/messageModule.dart';
import 'package:med_ease/Utils/Colors.dart';

class MessageScreen extends StatefulWidget {
  final String userId;
  final String doctorID;
  final String appointMentId;

  MessageScreen({
    required this.userId,
    required this.appointMentId,
    required this.doctorID,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  late IO.Socket socket;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  late List<MessageModule> listMessage = [];

  @override
  void initState() {
    connect();
    super.initState();
  }

  void connect() {
    socket = IO.io("http://0.0.0.0:5000", <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit('Id', widget.doctorID);

    socket.onConnect((data) {
      print("Connected");
      socket.on("messageEvent", (msg) {
        print(msg);
        setState(() {
          listMessage.add(MessageModule(
              isMe: false,
              message: msg['message'],
              doctorId: msg['doctorId'],
              userId: msg['userId']));
        });
      });
    });
  }

  void sendMessage(String messages, String sourceId, String targetId) {
    setState(() {
      listMessage.add(MessageModule(
          isMe: true, message: messages, doctorId: targetId, userId: sourceId));
    });
    socket.emit("messageEvent",
        {"message": messages, "sourceId": sourceId, "targetId": targetId});
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: listMessage.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, idx) {
                        return MessageListItem(
                            text: listMessage[idx].message,
                            isFromUser: listMessage[idx].isMe);
                      },
                      itemCount: listMessage.length,
                    )
                  : ListView(
                      children: const [
                        Text('No messages yet.'),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        hintText: 'Enter a message...',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        sendMessage(value, widget.userId, widget.doctorID);
                        _textController.clear();
                      },
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 15,
                  ),
                  if (!_loading)
                    IconButton(
                      onPressed: () {
                        sendMessage(_textController.text, widget.userId,
                            widget.doctorID);
                        _textController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageListItem({
    Key? key,
    required this.text,
    required this.isFromUser,
  }) : super(key: key);

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
