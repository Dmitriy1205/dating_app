import 'package:dating_app/core/constants.dart';
import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OwnMessageCard1 extends StatelessWidget {
  const OwnMessageCard1({super.key, required this.messageModel});

  final MessageModel messageModel;

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
            child: context
                .read<MessengerCubit>()
                .loggedUser
                .loggedUserPicture != '' ? Image.network(context
                .read<MessengerCubit>()
                .loggedUser
                .loggedUserPicture) : Image.asset(CustomIcons.photo),
            // fit: BoxFit.fill,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 55),
            child: messageModel.attachmentUrl == null
                ? messagePositioned(context)
                : attachmentPositioned(context)),
      ],
    );
  }

  Widget messagePositioned(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width - 150,
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
