import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          maxWidth: MediaQuery
              .of(context)
              .size
              .width - 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        Text(messageModel.time!,
                            style: const TextStyle(color: Colors.black54)),
                        Text('${messageModel.senderName} '),
                      ],
                    ),
                    // Text(
                    //   messageModel.message,
                    //   style:
                    //       const TextStyle(fontSize: 16, color: Colors.black87),
                    // ),
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

class OwnMessageCard1 extends StatelessWidget {
  const OwnMessageCard1(
      {super.key, required this.messageModel, required this.time});

  final MessageModel messageModel;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        const SizedBox(width: 10),
        Positioned(
            right: 55,
            child: Row(
              children: [
                Text(DateFormat.jm().format(
                    (DateTime.parse(messageModel.time!))),
                    style: const TextStyle(color: Colors.black54)),
                Text(' ${messageModel.senderName}'),
              ],
            )),
        SizedBox(
          height: 45,
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(Content.interestsList[3]),
            // fit: BoxFit.fill,
          ),
        ), Positioned(
            top: 20,
            right: 55,
            child:
            messageModel.attachmentUrl == null ? messagePositioned() : attachmentPositioned()),
      ],
    );
  }

  Widget messagePositioned() {
    return Text(
      ' ${messageModel.message}',
      style: const TextStyle(fontSize: 16, color: Colors.black87),
    );
  }
 Widget attachmentPositioned(){
    return Container(
      child: Image.network( messageModel.attachmentUrl!),
    );
 }
}


