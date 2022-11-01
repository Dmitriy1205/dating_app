import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/widgets/my_message.dart';
import 'package:dating_app/ui/widgets/receive_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/service_locator.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerStates>(
      builder: (context, state) {
        print('state ${state}');
        if (state is SendMessageState) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: messages(context, state),
                ),
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
    return Column(
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
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: state.messagesList.length,
            itemBuilder: (context, index) {
              if (index == state.messagesList.length) {
                print('1');
                return const SizedBox(
                  height: 70,
                  child: Icon(Icons.access_alarm),
                );
              }
              if (state.messagesList[index].type == "my") {
                print('2');
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                  child: OwnMessageCard1(
                    messageModel: state.messagesList[index],
                    time: state.messagesList[index].time!,
                  ),
                );
              } else {
                print('3');

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
                    onTap: () {},
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(CustomIcons.attachMessage)),
                  ),
                  InkWell(
                    onTap: () {
                      MessageModel message = MessageModel(
                          myMessageController.text,
                          'my',
                          DateFormat.jm().format(DateTime.now()),
                          'Yaroslav',
                          widget.user.firstName,
                          "${widget.user.firstName}+yar");
                      context.read<MessengerCubit>().sendMessage(message);
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
