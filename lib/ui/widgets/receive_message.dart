import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

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
            Text(messageModel.time,
                style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
      Positioned(
        top: 20,
        left: 55,
        child: Text(
          messageModel.message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      SizedBox(width: 10),
    ]);
  }
}
