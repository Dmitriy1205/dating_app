import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';

class OwnMessageCard1 extends StatelessWidget {
  const OwnMessageCard1({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    print('messageModel.senderName ${messageModel.senderName}');
    print('messageModel.recipientName ${messageModel.recipientName}');
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        const SizedBox(width: 10),
        Positioned(
            right: 55,
            child: Row(
              children: [
                Text(
                    DateFormat.jm()
                        .format((DateTime.parse(messageModel.time!))),
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
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 55),
            child: messageModel.attachmentUrl == null
                ? messagePositioned(context)
                : attachmentPositioned(context)),

      ],
    );
  }

  Widget messagePositioned(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 150,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          ' ${messageModel.message}',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          maxLines: 20,
        ),
      ),
    );
  }

  Widget attachmentPositioned(BuildContext context) {
    return Image.network(messageModel.message!);
  }
}
