import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/bloc/friends_list/friends_list_cubit.dart';
import 'package:dating_app/ui/bloc/settings/settings_cubit.dart';
import 'package:dating_app/ui/screens/blocked_contacts_screen.dart';
import 'package:dating_app/ui/screens/faq_screen.dart';
import 'package:dating_app/ui/screens/privacy_screen.dart';
import 'package:dating_app/ui/screens/terms.dart';
import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/service_locator.dart';
import '../bloc/blocked_contacts/blocked_contacts_cubit.dart';
import 'friend_list_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isToggle = true;

  @override
  Widget build(BuildContext context) {
    List<String> settingNames = [
      AppLocalizations.of(context)!.notifications,
      AppLocalizations.of(context)!.blockedContacts,
      AppLocalizations.of(context)!.friendList,
      AppLocalizations.of(context)!.faq,
      AppLocalizations.of(context)!.terms,
      AppLocalizations.of(context)!.privacyPolicy,
      AppLocalizations.of(context)!.logout,
    ];
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
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: settingNames.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    settingNames[index] == settingNames.first
                        ? const SizedBox()
                        : settingNames[index] == settingNames.last
                            ? showAlertDialog(context)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screens[index]));
                  },
                  child: SizedBox(
                    height: 80,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 25,
                                  child: Image.asset(
                                    Content.settingsList[index],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  settingNames[index],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            settingNames[index] == settingNames.first
                                ? FlutterSwitch(
                                    height: 22,
                                    width: 40,
                                    padding: 2,
                                    toggleSize: 17,
                                    activeColor: Colors.orange.shade700,
                                    onToggle: (value) {
                                      setState(() {
                                        isToggle = value;
                                      });
                                    },
                                    value: isToggle,
                                  )
                                : settingNames[index] == settingNames.last
                                    ? Container()
                                    : const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 12,
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLocalizations.of(context)!.logout),
      onPressed: () {
        BlocProvider.of<SettingsCubit>(context).logout().then((value) =>
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen())));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.warning),
      content: Text(AppLocalizations.of(context)!.areYouSure),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

List screens = [
  SizedBox(),
  BlocProvider(
    create: (context) => sl<BlockedContactsCubit>(),
    child: const BlockedContactsScreen(),
  ),
  BlocProvider(
    create: (context) => sl<FriendsListCubit>(),
    child: const FriendListScreen(),
  ),
  FaqScreen(),
  TermsAndConditions(),
  PrivacyScreen(),
  SizedBox(),
];
