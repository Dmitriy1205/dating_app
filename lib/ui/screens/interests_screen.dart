import 'package:dating_app/core/themes/checkboxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/constants.dart';

class InterestsScreen extends StatefulWidget {
  final Map<String, dynamic>? interests;

  const InterestsScreen({Key? key, this.interests}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // Map<String, dynamic> interests = Interests().toMap();

  @override
  Widget build(BuildContext context) {
    List<String> interests = [
      AppLocalizations.of(context)!.photography,
      AppLocalizations.of(context)!.acting,
      AppLocalizations.of(context)!.film,
      AppLocalizations.of(context)!.finArt,
      AppLocalizations.of(context)!.music,
      AppLocalizations.of(context)!.fashion,
      AppLocalizations.of(context)!.dance,
      AppLocalizations.of(context)!.politics,
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    splashRadius: 0.1,
                                    iconSize: 28,
                                    alignment: Alignment.topLeft,
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.interests,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  //TODO: submit all data and back
                                  Navigator.pop(context, widget.interests);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.done,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.interests!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Stack(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.interests!.update(
                                          widget.interests!.keys.elementAt(i),
                                          (value) => !value);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      width: 170,
                                      height: 168,
                                      child: Image.asset(
                                        Content.interestsList[i],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 16,
                                child: Text(
                                  interests[i],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      backgroundColor: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                  right: 17,
                                  top: 14,
                                  child: widget.interests!.values.elementAt(i)
                                      ? CustomCheckbox.checked()
                                      : CustomCheckbox.unChecked()),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
