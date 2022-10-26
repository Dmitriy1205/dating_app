import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/widgets/my_message.dart';
import 'package:dating_app/ui/widgets/receive_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';

class MessengerWidget extends StatefulWidget {
  const MessengerWidget({Key? key}) : super(key: key);

  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  TextEditingController myMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(child: messages())),
        typeMessage()
      ],
    );
  }

  MessageModel message1 =
      MessageModel('Hey! Are You There?', 'sim', '08:00 Am', 'John');
  MessageModel message2 = MessageModel('Yeah', 'my', '08:02 Am', 'Sophia');
  late MessageModel messageModel;
  List<MessageModel> messagesList = [];

  Widget messages() {
    messagesList.addAll([message1, message2]);

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
            )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: messagesList.length,
            itemBuilder: (context, index) {
              print('alllllllll');

              if (index == messagesList.length) {
                print('1');
                return const SizedBox(
                  height: 70,
                  child: Icon(Icons.access_alarm),
                );
              }
              if (messagesList[index].type == "my") {
                print('2');
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                  child: OwnMessageCard1(
                    messageModel: messagesList[index],
                    time: messagesList[index].time,
                  ),
                );
              } else {
                print('3');

                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: ReplyCard(
                    messageModel: messagesList[index],
                    time: messagesList[index].time,
                  ),
                );
              }
            }),
      ],
    );
  }

  Widget typeMessage() {
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
                                'Sophia');
                            messagesList.add(message);
                            setState(() {
                            });
                          },
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(CustomIcons.sendMessage)),
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}
