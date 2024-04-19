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
  final bool isDoctor;

  MessageScreen({
    required this.userId,
    required this.isDoctor,
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
    socket = IO.io("http://0.0.0.0:3001", <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit(
        'Id', widget.isDoctor == true ? widget.doctorID : widget.userId);

    socket.onConnect((data) {
      print("Connected");
      socket.on("messageEvent", (msg) {
        print(msg);
        setState(() {
          listMessage.add(MessageModule(
              time: msg['time'],
              isDoctor: msg['isDoctor'],
              message: msg['message'],
              reciverId: msg['reciverId'],
              currentId: msg['currentId']));
        });
      });
    });
  }

  void sendMessage(
      {required String messages,
      required String currentId,
      required String reciverId,
      required bool isDoctor}) {
    setState(() {
      listMessage.add(MessageModule(
          time: DateTime.now().toString(),
          message: messages,
          currentId: currentId,
          reciverId: reciverId,
          isDoctor: isDoctor));
    });
    socket.emit("messageEvent", {
      "time": DateTime.now().toString(),
      "message": messages,
      "currentId": currentId,
      "reciverId": reciverId,
      "isDoctor": isDoctor
    });
  }

  @override
  Widget build(BuildContext context) {
    //final userModel = context.watch<UserBloc>().state;

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
                            isFromUser: listMessage[idx].isDoctor);
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
                        widget.isDoctor == false
                            ? sendMessage(
                                messages: value,
                                currentId: widget.userId,
                                reciverId: widget.doctorID,
                                isDoctor: widget.isDoctor)
                            : sendMessage(
                                messages: value,
                                currentId: widget.doctorID,
                                reciverId: widget.userId,
                                isDoctor: widget.isDoctor);
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
                        widget.isDoctor == false
                            ? sendMessage(
                                messages: _textController.text,
                                currentId: widget.userId,
                                reciverId: widget.doctorID,
                                isDoctor: widget.isDoctor)
                            : sendMessage(
                                messages: _textController.text,
                                currentId: widget.doctorID,
                                reciverId: widget.userId,
                                isDoctor: widget.isDoctor);
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
