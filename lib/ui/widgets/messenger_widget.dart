import 'package:dating_app/data/models/message_model.dart';
import 'package:dating_app/ui/widgets/my_message.dart';
import 'package:dating_app/ui/widgets/receive_message.dart';
import 'package:flutter/material.dart';

class MessengerWidget extends StatefulWidget {
  const MessengerWidget({Key? key}) : super(key: key);

  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  TextEditingController myMessage = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
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
          messages()
        ]),
      ),
    );
  }

  MessageModel message1 =
      MessageModel('message1', 'simple', '08:00 AM', 'John');
  MessageModel message2 =
      MessageModel('message2', 'sim', '08:02 AM', 'Sophia');
  List<MessageModel> messagesList = [];

  Widget messages() {
    messagesList.addAll([message1, message2]);
    return ListView.builder(shrinkWrap: true,controller: _scrollController,
        itemCount: messagesList.length, itemBuilder: (context, index) {
          print('alllllllll');

          if (index == messagesList.length) {
        print('1');
        return Container(child: Icon(Icons.access_alarm),
          height: 70,
        );
      }
      if (messagesList[index].type == "simple") {
        print('2');
        return OwnMessageCard(
          messageModel: messagesList[index],
          time: messagesList[index].time,
        );
      } else {
        print('3');

        return ReplyCard(
          messageModel: messagesList[index],
          time: messagesList[index].time,
        );
      }
    });
  }
}
