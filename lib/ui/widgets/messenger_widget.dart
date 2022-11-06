import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/widgets/my_message.dart';
import 'package:dating_app/ui/widgets/receive_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../data/models/user_model.dart';
import '../bloc/messenger_cubit.dart';

class MessengerWidget extends StatefulWidget {
  MessengerWidget(BuildContext context, {required this.user}) : super();
  final UserModel user;

  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  TextEditingController myMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  _MessengerWidgetState();

  @override
  void initState() {
    context.read<MessengerCubit>().messagesStream(widget.user);
    super.initState();
  }

  @override
  void dispose() {
    context.read<MessengerCubit>().messagesStream(widget.user);
    print('disposed');
    super.dispose();
  }

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
        } else {
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
        }
      },
    );
  }

  Widget messages(BuildContext context, SendMessageState state) {
    return StreamBuilder<List<MessageModel>>(
        stream: context.read<MessengerCubit>().messagesStream(widget.user),
        builder: (context, snapshot) {
          print('snapshot ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.active) {
            print('snapshot.done ${snapshot.data?.first.message}');
            if (snapshot.hasData) {
              return SingleChildScrollView(
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.length) {
                            print(
                                'state.messagesList.length ${snapshot.data!.length}');
                            return const SizedBox(
                              height: 70,
                              child: Icon(Icons.access_alarm),
                            );
                          }
                          if (snapshot.data![index].recipientName ==
                              widget.user.firstName) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                              child: OwnMessageCard1(
                                messageModel: snapshot.data![index],
                                time: snapshot.data![index].time!,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                              child: ReplyCard(
                                messageModel: snapshot.data![index],
                                time: snapshot.data![index].time!,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              );
            } else {
              return Text('No data found');
            }
          }
          if (snapshot.connectionState == ConnectionState.none) {
            print('no data');
            return Text('no data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');

            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text('ConnectionState.none');
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else
            return Text('Unknown problem');
        });
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
                    onTap: () {},
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
                          senderName: '',
                          recipientName: widget.user.firstName,
                          chatId: '');
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
