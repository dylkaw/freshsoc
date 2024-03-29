import "package:flutter/material.dart";
import "package:freshsoc/models/user_model.dart";
import "package:freshsoc/shared/constants.dart";

class ChatMessage extends StatefulWidget {
  const ChatMessage(
      {super.key,
      required this.message,
      required this.sender,
      required this.userModel});

  final String message;
  final String sender;
  final UserModel? userModel;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    if (widget.sender == 'Soccat') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/soccat.png')
                  as ImageProvider<Object>,
            ),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.sender,
                    style: TextStyle(
                        color: nusOrange, fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(widget.message),
                )
              ]))
        ]),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: CircleAvatar(
              backgroundImage: widget.userModel == null
                  ? const AssetImage('assets/images/soccat.png')
                      as ImageProvider<Object>
                  : NetworkImage(widget.userModel!.profilePictureUrl)
                      as ImageProvider<Object>,
            ),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Me',
                    style:
                        TextStyle(color: nusBlue, fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(widget.message),
                ),
              ]))
        ]),
      );
    }
  }
}
