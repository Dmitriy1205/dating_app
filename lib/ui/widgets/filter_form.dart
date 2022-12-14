import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/filter/filter_cubit.dart';

class FilterForm extends StatelessWidget {
  FilterForm({Key? key}) : super(key: key);

  RangeValues yearsRange = RangeValues(0, 0);

  int distance = 0;

  String gender = '';

  Map<String, dynamic> lookingFor = {};
  Map<String, dynamic> hobbies = {};
  Map<String, dynamic> interest = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<String> lookin = [
          AppLocalizations.of(context)!.aMentee,
          AppLocalizations.of(context)!.aFriend,
          AppLocalizations.of(context)!.someoneToChillWith,
          AppLocalizations.of(context)!.aRomanticPartner,
          AppLocalizations.of(context)!.aBusinessPartner,
          AppLocalizations.of(context)!.aMentor,
        ];
        List<String> inter = [
          AppLocalizations.of(context)!.photography,
          AppLocalizations.of(context)!.acting,
          AppLocalizations.of(context)!.film,
          AppLocalizations.of(context)!.finArt,
          AppLocalizations.of(context)!.music,
          AppLocalizations.of(context)!.fashion,
          AppLocalizations.of(context)!.dance,
          AppLocalizations.of(context)!.politics,
        ];
        List<String> hobb = [
          AppLocalizations.of(context)!.workingOut,
          AppLocalizations.of(context)!.reading,
          AppLocalizations.of(context)!.cooking,
          AppLocalizations.of(context)!.biking,
          AppLocalizations.of(context)!.drinking,
          AppLocalizations.of(context)!.shopping,
          AppLocalizations.of(context)!.hiking,
          AppLocalizations.of(context)!.baking,
        ];
        // final id = state.searchFields!.id;
        lookingFor = state.lookingFor!;
        hobbies = state.hobbies!;
        interest = state.interests!;
        yearsRange = state.age!;
        distance = state.distance!;
        gender = state.gender!;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.lookingFor,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.lookingFor,
                    onTap: (s) {
                  context.read<FilterCubit>().setLookingForFields(s!);
                }, set: (v) {
                  lookingFor = v;
                }, names: lookin),
                Text(
                  AppLocalizations.of(context)!.sharedHobbies,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.hobbies,
                    onTap: (hobb) {
                  context.read<FilterCubit>().setHobbieFields(hobb!);
                }, set: (v) {
                  hobbies = v;
                }, names: hobb),
                Text(
                  AppLocalizations.of(context)!.sharedInterests,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.interests,
                    onTap: (inter) {
                  context.read<FilterCubit>().setInterestFields(inter!);
                }, set: (v) {
                  interest = v;
                }, names: inter),
                // Text(
                //   AppLocalizations.of(context)!.location,
                //   style: const TextStyle(
                //       color: Colors.black, fontWeight: FontWeight.bold),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 10,
                //     bottom: 40,
                //   ),
                //   child: TextFormField(
                //     autocorrect: false,
                //     keyboardType: TextInputType.name,
                //     decoration: profileFieldDecor(AppLocalizations.of(context)!.location),
                //   ),
                // ),
                Text(
                  AppLocalizations.of(context)!.searchPreferences,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.age),
                    Text(
                        '${state.age!.start.round().toString()} - ${state.age!.end.round().toString()}',
                        style: const TextStyle(color: Colors.black45)),
                  ],
                ),
                RangeSlider(
                    values: state.age!,
                    onChanged: (newYears) {
                      context.read<FilterCubit>().setAge(newYears);
                      // yearsRange = {
                      //   'start': state.age!.start.round(),
                      //   'end': state.age!.end.round()
                      // };
                    },
                    min: 15,
                    max: 55),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.distance),
                      Text('${state.distance.toString()} ${AppLocalizations.of(context)!.miles}',
                          style: const TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),
                Slider(
                    value: state.distance!.toDouble(),
                    onChanged: (newDistance) {
                      context
                          .read<FilterCubit>()
                          .setDistance(newDistance.toInt());
                      distance = newDistance.toInt();
                    },
                    min: 0,
                    max: 70),
                 Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    AppLocalizations.of(context)!.gender,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 50,
                  ),
                  child: Ink(
                    child: Container(
                      height: 57,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Center(
                          child: DropdownButtonFormField(
                            value: state.gender,
                            hint: Text(AppLocalizations.of(context)!.gender),
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey[500],
                            ),
                            onChanged: (v) {
                              context
                                  .read<FilterCubit>()
                                  .setGender(v.toString());
                              gender = v.toString();
                            },
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: Colors.white,
                            ),
                            // decoration: profileFieldDecor('Gender'),
                            items: [
                              DropdownMenuItem(
                                value: "Male",
                                child: Text(
                                  AppLocalizations.of(context)!.male,
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Female",
                                child: Text(
                                  AppLocalizations.of(context)!.female,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<FilterCubit>()
                            .saveFilter(
                              SearchPrefFields()
                                ..lookingFor = lookingFor
                                ..hobbies = hobbies
                                ..interests = interest
                                ..yearsRange = {
                                  'start': state.age!.start.round(),
                                  'end': state.age!.end.round()
                                }
                                ..distance = distance
                                ..gender = gender
                                ,
                            )
                            .then((value) =>
                                Navigator.of(context).popAndPushNamed('home'));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment(0.1, 2.1),
                              colors: [
                                Colors.orange,
                                Colors.purple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          width: 340,
                          height: 55,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.apply,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
