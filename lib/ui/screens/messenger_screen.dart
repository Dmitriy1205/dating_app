import 'dart:convert';

import 'package:dating_app/core/constants.dart';
import 'package:dating_app/data/models/call_model.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/bloc/register_call/register_call_cubit.dart';
import 'package:dating_app/ui/screens/video_call_screen.dart';
import 'package:dating_app/ui/widgets/messenger_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../core/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/services/cache_helper.dart';
import '../bloc/video_call/video_call_cubit.dart';

class MessengerScreen extends StatefulWidget {
  MessengerScreen({
    Key? key,
    required this.user,
    required this.userPicture,
    this.currentUserid,
    this.currentUserName,
  }) : super(key: key);
  final UserModel user;
  final String? currentUserid;
  final String? currentUserName;
  final String userPicture;

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  final String callModelId = 'call_${UniqueKey().hashCode.toString()}';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: sl<MessengerCubit>(),
        // create: (BuildContext context) => sl<MessengerCubit>(),
        child: BlocListener<RegisterCallCubit, RegisterCallState>(
          listener: (context, state) {
            if (state.inCallStatus == IncomingCallStatus.successOuterCall) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => VideoCallScreen(
                        receiverId: widget.user.id!,
                        id: callModelId,
                        isReceiver: false,
                      )));
            } else if (state.status!.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  content: Text(
                    state.status!.errorMessage!,
                  ),
                ),
              );
            }
          },
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
                title: Padding(
                  padding: const EdgeInsets.only(left: 105),
                  child: Text(
                    widget.user.firstName!,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        context.read<RegisterCallCubit>().makeCall(
                                callModel: CallModel(
                              id: callModelId,
                              callerId: CacheHelper.getString(key: 'uId'),
                              callerName: widget.currentUserName,
                              receiverId: widget.user.id,
                              receiverName: widget.user.firstName,
                              status: CallStatus.ringing.name,
                              current: true,
                            ));
                      },
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                            'assets/icons/video.png',
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            if (choice == 'Clear Chat' ||
                                choice == 'Vacie la conversacion' ||
                                choice == 'Effacer le chat' ||
                                choice == 'Limpar conversa') {
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
                  user: widget.user, userPicture: widget.userPicture)),
        ));
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
