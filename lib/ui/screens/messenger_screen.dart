import 'package:dating_app/core/constants.dart';
import 'package:dating_app/data/models/call_model.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/bloc/notification/notification_cubit.dart';
import 'package:dating_app/ui/bloc/register_call/register_call_cubit.dart';
import 'package:dating_app/ui/widgets/messenger_widget.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/services/cache_helper.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({
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
  void initState() {
    context.read<NotificationCubit>().cancel();
    context.read<MessengerCubit>().getUsersBlock(
          currentUserId: widget.currentUserid!,
          blockerUserId: widget.user.id!,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Center(
            child: Text(
              widget.user.firstName!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            context.watch<MessengerCubit>().state.userBlocked == true
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        DateTime now = DateTime.now();
                        String formattedDateTime =
                            DateFormat('yyyy-MM-dd HH:mm').format(now);
                        context.read<NotificationCubit>().sendCallNotification(
                            userId: widget.user.id!,
                            callerName: widget.currentUserName!);
                        context.read<RegisterCallCubit>().makeCall(
                                callModel: CallModel(
                              id: '${widget.currentUserid}+${widget.user.id}',
                              callerId: CacheHelper.getString(key: 'uId'),
                              callerAvatar: widget.userPicture,
                              callerName: widget.currentUserName,
                              receiverId: widget.user.id,
                              receiverName: widget.user.firstName,
                              receiverAvatar: widget.user.profileInfo!.image,
                              status: CallStatus.ringing.name,
                              createAt: formattedDateTime,
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
                return BlocProvider.of<MessengerCubit>(context)
                            .state
                            .userBlocked ==
                        true
                    ? {
                        AppLocalizations.of(context)!.block,
                        AppLocalizations.of(context)!.reportUser,
                        AppLocalizations.of(context)!.unfriend
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          onTap: () {
                            if (choice == 'Block' ||
                                choice == 'Bloquear' ||
                                choice == 'Bloquer' ||
                                choice == 'Quadra') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showBlockDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
                            } else if (choice == 'Report User' ||
                                choice == 'Reportar usuario' ||
                                choice == 'Dénoncer un utilisateur' ||
                                choice == 'Reportar usuário') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showReportDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
                            } else if (choice == 'Unfriend' ||
                                choice == 'No amigo' ||
                                choice == 'Désami' ||
                                choice == 'Tirar amizade') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showUnfriendDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
                            }
                          },
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList()
                    : {
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
                            } else if (choice == 'Block' ||
                                choice == 'Bloquear' ||
                                choice == 'Bloquer' ||
                                choice == 'Quadra') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showBlockDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
                            } else if (choice == 'Report User' ||
                                choice == 'Reportar usuario' ||
                                choice == 'Dénoncer un utilisateur' ||
                                choice == 'Reportar usuário') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showReportDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
                            } else if (choice == 'Unfriend' ||
                                choice == 'No amigo' ||
                                choice == 'Désami' ||
                                choice == 'Tirar amizade') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ReUsableWidgets.showUnfriendDialog(
                                  context,
                                  widget.user.firstName!,
                                  widget.user.id!,
                                );
                              });
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
        body: MessengerWidget(
          context,
          user: widget.user,
          userPicture: widget.userPicture,
          recieverId: widget.user.id!,
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
