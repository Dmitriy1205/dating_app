import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filter/filter_cubit.dart';
import 'field_decor.dart';

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
        final id = state.searchFields!.id;
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
                const Text(
                  'Looking For',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.lookingFor,
                    onTap: (s) {
                  context.read<FilterCubit>().setLookingForFields(s!);
                }, set: (v) {
                  lookingFor = v;
                }),
                const Text(
                  'Shared hobbies',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.hobbies,
                    onTap: (hobb) {
                  context.read<FilterCubit>().setHobbieFields(hobb!);
                }, set: (v) {
                  hobbies = v;
                }),
                const Text(
                  'Shared interests',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                ReUsableWidgets.buildExpansionList(context, state.interests,
                    onTap: (inter) {
                  context.read<FilterCubit>().setInterestFields(inter!);
                }, set: (v) {
                  interest = v;
                }),
                const Text(
                  'Location',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 40,
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: profileFieldDecor('Location'),
                  ),
                ),
                const Text(
                  'SEARCH PREFERENCES',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Age'),
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
                      const Text('Distance'),
                      Text('${state.distance.toString()} miles',
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
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Gender',
                    style: TextStyle(
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
                            hint: const Text('Gender'),
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
                            items: const [
                              DropdownMenuItem(
                                value: "Male",
                                child: Text(
                                  "Male",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Female",
                                child: Text(
                                  "Female",
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
                                ..id = id,
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
                          child: const Text(
                            'APPLY',
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
