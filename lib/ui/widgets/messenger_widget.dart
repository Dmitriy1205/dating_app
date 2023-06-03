import 'dart:typed_data';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/notification/notification_cubit.dart';

class MessengerWidget extends StatefulWidget {
  const MessengerWidget(BuildContext context,
      {super.key,
      required this.user,
      required this.userPicture,
      required this.recieverId});

  final UserModel user;
  final String userPicture;
  final String recieverId;

  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  TextEditingController myMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<MessengerCubit>().messagesStream(widget.user.id!);
    context.read<MessengerCubit>().getChatId2(widget.user.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerStates>(
      builder: (context, state) {
        if (state.status!.isLoaded) {
          return state.userBlocked == true
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.sorry}\n',
                                ),
                                TextSpan(
                                  text: '${widget.user.firstName}\n',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .isBlockedYou)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: messages(context, state),
                    ),
                    typeMessage(context, state)
                  ],
                );
        } else if (state.status!.isInitial) {
          return Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text('send your first message '),
                ),
              ),
              typeMessage(context, state)
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

  Widget messages(BuildContext context, state) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: Colors.black54),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(AppLocalizations.of(context)!.today),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: Divider(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: state.messagesList.length,
              itemBuilder: (context, index) {
                if (state.messagesList[index].recipientName ==
                    widget.user.firstName) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                    child: OwnMessageCard1(
                      messageModel: state.messagesList[index],
                    ),
                  );
                } else {
                  if (!state.messagesList[index].isRead) {
                    context
                        .read<MessengerCubit>()
                        .palReadMessage(state.messagesList[index]);
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: ReplyCard(
                        messageModel: state.messagesList[index],
                        time: state.messagesList[index].time!,
                        userPicture: widget.userPicture),
                  );
                }
              }),
        )
      ],
    );
  }

  Widget typeMessage(BuildContext context, state) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 23),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextFormField(
            maxLines: 5,
            minLines: 1,
            controller: myMessageController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15),
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.typeYourMessage,
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
                          func: (Uint8List? f) async {
                            String? messageUrl = await context
                                .read<ImagePickerCubit>()
                                .uploadMessageImage(f!,
                                    context.read<MessengerCubit>().getChatId);
                            MessageModel message = MessageModel(
                                message: messageUrl,
                                recipientName: widget.user.firstName);
                            if(context.mounted){
                              context
                                  .read<MessengerCubit>()
                                  .sendMessage(message, widget.user, true);
                            }

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
                        if (myMessageController.text != '') {
                          if (state.status!.isLoaded) {
                            _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          }
                          MessageModel message = MessageModel(
                            message: myMessageController.text,
                            time: DateTime.now().toString(),
                            recipientName: widget.user.firstName,
                          );
                          context
                              .read<NotificationCubit>()
                              .sendMessageNotification(
                                userId: widget.recieverId,
                                senderName: widget.user.firstName!,
                                message: myMessageController.text,
                              );
                          context
                              .read<MessengerCubit>()
                              .sendMessage(message, widget.user);
                          myMessageController.clear();
                        }
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
      ),
    );
  }
}
