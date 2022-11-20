import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/themes/text_styles.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.messageModel, required this.time});

  final MessageModel messageModel;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
        height: 45,
        width: 45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(Content.interestsList[4]),
          // fit: BoxFit.fill,
        ),
      ),
      Positioned(
        left: 55,
        child: Row(
          children: [
            Text('${messageModel.senderName} ',
                style: CustomTextStyle.customFontStyle()),
            Text(DateFormat.jm().format((DateTime.parse(messageModel.time!))),
                style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 20,
            left: 55),
          child: messageModel.attachmentUrl == null
              ? messagePositioned()
              : attachmentPositioned()),
      Positioned(
          height: 200,
          top: 20,
          left: 55,
          child: messageModel.attachmentUrl == null
              ? messagePositioned()
              : attachmentPositioned()),

      SizedBox(width: 10),
    ]);
  }

  Widget messagePositioned() {
    return Text(
      ' ${messageModel.message}',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
    );
  }

  Widget attachmentPositioned() {
    return Image.network(messageModel.message!);
  }
}
