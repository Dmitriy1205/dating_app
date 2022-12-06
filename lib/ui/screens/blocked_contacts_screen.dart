import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/constants.dart';

class BlockedContactsScreen extends StatelessWidget {
  const BlockedContactsScreen({Key? key}) : super(key: key);

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
        title: Text(
          AppLocalizations.of(context)!.blockedContacts,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: Content.settingNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: SizedBox(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 10.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              child: Image.asset(
                                Content.hobbiesList[index],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // submit(context);
                          // if (!_formKey.currentState!.validate()) {
                          //   return;
                          // }
                          //
                          // _formKey.currentState!.save();
                          //TODO: Add phone auth with email link auth to signup
                          // context.read<AuthCubit>().signUp(
                          //       phoneNumber: _phoneController.text,
                          //       verificationId: verificationId,
                          //       navigateTo: Navigator.push<void>(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               const OtpVerificationScreen(),
                          //         ),
                          //       ),
                          //     );
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment(0.1, 1.5),
                                colors: [
                                  Colors.orange,
                                  Colors.purple,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            width: 75,
                            height: 30,
                            alignment: Alignment.center,
                            child: const Text(
                              'Undo',
                            ),
                          ),
                        ),
                      ),
                    ],
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
