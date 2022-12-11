import 'package:dating_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/themes/checkboxes.dart';

class HobbiesScreen extends StatefulWidget {
  final Map<String, dynamic>? hobbies;

  const HobbiesScreen({Key? key, this.hobbies}) : super(key: key);

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> hobbies = [
      AppLocalizations.of(context)!.workingOut,
      AppLocalizations.of(context)!.reading,
      AppLocalizations.of(context)!.cooking,
      AppLocalizations.of(context)!.biking,
      AppLocalizations.of(context)!.drinking,
      AppLocalizations.of(context)!.shopping,
      AppLocalizations.of(context)!.hiking,
      AppLocalizations.of(context)!.baking,
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
                                    AppLocalizations.of(context)!.hobbies,
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
                                  Navigator.pop(context, widget.hobbies);
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 5),
                            child: Text(
                              AppLocalizations.of(context)!.howDoYouLike,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.hobbies!.length,
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
                                      widget.hobbies!.update(
                                          widget.hobbies!.keys.elementAt(i),
                                          (value) => !value);
                                    });
                                    //
                                    // bool ho = hobbies.update(
                                    //     hobbies.keys.elementAt(i),
                                    //     (value) => !value);
                                    // context.read<HobbiesCubit>().check(ho);
                                    //
                                    // hobbies;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      width: 170,
                                      height: 168,
                                      child: Image.asset(
                                        Content.hobbiesList[i],
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
                                  hobbies[i],
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
                                  child: widget.hobbies!.values.elementAt(i)
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
