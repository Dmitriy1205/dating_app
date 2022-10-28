import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/widgets/messenger_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => MessengerCubit(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              padding: const EdgeInsets.fromLTRB(23, 20, 8, 8),
              onPressed: () {
                Navigator.pop(context);
              },
              splashRadius: 0.1,
              iconSize: 28,
              alignment: Alignment.topLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.orange,
                size: 18,
              ),
            ),
            title: Text(
              user.firstName!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Block', 'Clear Chat', 'Report User', 'Unfriend'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: MessengerWidget(context, user: user),
        ));

    // );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
