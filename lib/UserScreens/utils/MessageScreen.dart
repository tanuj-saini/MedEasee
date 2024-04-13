import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:med_ease/Modules/testModule.dart'; // Import necessary modules
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/utils/messageModule.dart'; // Import necessary modules
import 'package:med_ease/Utils/Colors.dart'; // Import necessary modules
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
    return _MessageScreen();
  }
}

class _MessageScreen extends State<MessageScreen> {
  late IO.Socket socket;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  late List<messageList> listMessage = [];

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
    socket.emit('Id', widget.userId);
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.on('messageEvent', (msg) {
        print(msg);
        setState(() {
          // Assuming your message format is a String
          listMessage.add(messageList(text: msg["message"], isFromUser: true));
        });
      });
    });
  }

  void sendMessage(String messages, String sourceId, String targetId) {
    messageList message = messageList(text: messages, isFromUser: true);
    listMessage.add(message);

    socket.emit("messageEvent",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  @override
  void dispose() {
    socket.dispose(); // Dispose socket when not needed
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
                        return listMessage[idx];
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

class MessageWidget extends StatelessWidget {
  final String messaage;
  final bool isFromUser;

  const MessageWidget({
    required this.messaage,
    required this.isFromUser,
    Key? key,
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
              data: messaage,
            ),
          ),
        ),
      ],
    );
  }
}
