import 'dart:io';

import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/widgets/my_message.dart';
import 'package:dating_app/ui/widgets/receive_message.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../data/models/user_model.dart';
import '../bloc/image_picker/image_picker_cubit.dart';
import '../bloc/messenger_cubit.dart';

class MessengerWidget extends StatefulWidget {
  const MessengerWidget(BuildContext context, {super.key, required this.user});

  final UserModel user;

  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  TextEditingController myMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  _MessengerWidgetState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerStates>(
      builder: (context, state) {
        print('state ${state}');
        if (state is SendMessageState) {
          return Column(
            children: [
              Expanded(
                child: messages(context, state),
              ),
              typeMessage(context)
            ],
          );
        } else if (state is MessengerInit) {
          return Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text('send your first message '),
                ),
              ),
              typeMessage(context)
            ],
          );
        } else {
          return Column(
            children: const [
              Expanded(
                child: Center(
                  child: Text('Error, no states found'),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget messages(BuildContext context, SendMessageState state) {
    return SingleChildScrollView(
      // controller: _scrollController,
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Divider(color: Colors.black54),
              ),
              SizedBox(
                width: 15,
              ),
              Text("today"),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Divider(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.builder(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.messagesList.length,
              itemBuilder: (context, index) {
                if (index == state.messagesList.length) {
                  return const SizedBox(
                    height: 70,
                    child: Icon(Icons.access_alarm),
                  );
                }
                if (state.messagesList[index].recipientName ==
                    widget.user.firstName) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                    child: OwnMessageCard1(
                      messageModel: state.messagesList[index],
                      time: state.messagesList[index].time!,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: ReplyCard(
                      messageModel: state.messagesList[index],
                      time: state.messagesList[index].time!,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget typeMessage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextFormField(
          controller: myMessageController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Type your message...",
            hintStyle: const TextStyle(color: Colors.grey),
            prefix: const SizedBox(
              width: 20,
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      ReUsableWidgets().showPicker(
                        context,
                        func: (File? f) async {
                          String? chatId = await context
                              .read<ImagePickerCubit>()
                              .uploadMessageImage(
                                  f!, context.read<MessengerCubit>().getChatId);
                          MessageModel message = MessageModel(
                              chatId: chatId,
                              recipientName: widget.user.firstName,
                              time: DateTime.now().toString());
                          context
                              .read<MessengerCubit>()
                              .sendMessage(message, widget.user);
                        },
                      );
                    },
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(CustomIcons.attachMessage)),
                  ),
                  InkWell(
                    onTap: () {
                      MessageModel message = MessageModel(
                          message: myMessageController.text,
                          time: DateTime.now().toString(),
                          senderName: null,
                          recipientName: widget.user.firstName,
                          chatId: null);
                      context
                          .read<MessengerCubit>()
                          .sendMessage(message, widget.user);
                      myMessageController.clear();
                    },
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(CustomIcons.sendMessage)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
