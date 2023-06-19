import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:freshsoc/screens/socialize/view_post.dart';
import 'package:intl/intl.dart';

class ReplyCard extends StatefulWidget {
  final String name;
  final String course;
  final DateTime dateTime;
  final String reply;

  const ReplyCard({
    super.key,
    required this.name,
    required this.course,
    required this.dateTime,
    required this.reply,
  });

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width * 0.95,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 192, 219, 234),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.name} - ${widget.course}"),
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(widget.dateTime),
            style: const TextStyle(color: Color(0xFF8A8A8A)),
          ),
          const SizedBox(height: 5.0),
          Text(
            widget.reply,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
