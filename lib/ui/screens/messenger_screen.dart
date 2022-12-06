import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/widgets/messenger_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen(
      {Key? key, required this.user, required this.userPicture})
      : super(key: key);
  final UserModel user;

  final String userPicture;

  @override
  Widget build(BuildContext context) {
    print('user $user');
    return BlocProvider(
        create: (BuildContext context) => sl<MessengerCubit>(),
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
                    return {
                      AppLocalizations.of(context)!.block,
                      AppLocalizations.of(context)!.clearChat,
                      AppLocalizations.of(context)!.reportUser,
                      AppLocalizations.of(context)!.unfriend
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        onTap: () {
                          switch (choice) {
                            case 'Clear Chat':
                              context.read<MessengerCubit>().clearChat();
                          }
                        },
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: MessengerWidget(context,
                user: user, userPicture: userPicture)));
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
