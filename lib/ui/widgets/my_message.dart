import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard(
      {super.key, required this.messageModel, required this.time});

  final MessageModel messageModel;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(Content.interestsList[3]),
                    // fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Text('${messageModel.senderName} '),
                        Text(messageModel.time,
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                    Text(
                      messageModel.message,
                      style: const TextStyle(
                        fontSize: 16, color: Colors.black87
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
