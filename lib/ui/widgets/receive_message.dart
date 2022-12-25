import 'package:dating_app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/themes/text_styles.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {super.key,
      required this.messageModel,
      required this.time,
      required this.userPicture});

  final MessageModel messageModel;
  final String time;
  final String userPicture;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topStart, children: [
      SizedBox(
        height: 45,
        width: 45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: userPicture != ''
              ? Image.network(
                  userPicture,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/empty.png',
                  fit: BoxFit.cover,
                ),
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
          padding: const EdgeInsets.only(top: 35, left: 55),
          child: messageModel.attachmentUrl == null
              ? messagePositioned(context)
              : attachmentPositioned()),
    ]);
  }

  Widget messagePositioned(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 150,
      child: Text(
        maxLines: 20,
        ' ${messageModel.message}',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget attachmentPositioned() {
    return Image.network(messageModel.message!);
  }
}
