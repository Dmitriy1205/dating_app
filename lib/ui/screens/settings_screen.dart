import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/screens/blocked_contacts_screen.dart';
import 'package:dating_app/ui/screens/faq_screen.dart';
import 'package:dating_app/ui/screens/privacy_screen.dart';
import 'package:dating_app/ui/screens/terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'friend_list_screen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isToggle = true;

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
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: Content.settingNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: () {
                Content.settingNames[index] == Content.settingNames.first
                    ? const SizedBox()
                    : Content.settingNames[index] == Content.settingNames.last
                        ? Container()
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
                              Content.settingNames[index],
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Content.settingNames[index] ==
                                Content.settingNames.first
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
                            : Content.settingNames[index] ==
                                    Content.settingNames.last
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
      ),
    );
  }
}

List screens = [
  SizedBox(),
  BlockedContactsScreen(),
  FriendListScreen(),
  FaqScreen(),
  TermsAndConditions(),
  PrivacyScreen(),
  SizedBox(),
];
