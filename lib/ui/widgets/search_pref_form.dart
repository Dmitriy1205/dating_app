import 'package:dating_app/core/constants.dart';
import 'package:dating_app/core/themes/text_styles.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/ui/bloc/search_preferences_bloc.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_preferances_state.dart';
import '../screens/home_screen.dart';
import 'field_decor.dart';

class SearchPrefForm extends StatelessWidget {
  SearchPrefForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  ReUsableWidgets reUsableWidgets = ReUsableWidgets();
  String gender = 'Gender';

  int distance = 28;

  Map<String, dynamic>? lookingFor = {
    'someone to chill with': false,
    'a friend': false,
    'a romantic partner': false,
    'a business partner': false,
    'a mentor': false,
    'a mentee': false
  };
  Map<String, dynamic> hobbies = {
    'WorkingOut': true,
    'Hiking': true,
    'Biking': true,
    'Shopping': true,
    'Cooking': true,
    'Baking': true,
    'Drinking': true,
    'Reading': true,
  };
  Map<String, dynamic> interests = {
    'Politics': true,
    'Fashion': true,
    'FinArt': true,
    'Music': true,
    'Dance': true,
    'Film': true,
    'Photography': true,
    'Acting': true,
  };
  Map<String, int>? yearsRange = {'start': 20, 'end': 30};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPreferencesCubit, SearchPreferencesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 10, 0),
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
                                    const Text(
                                      'Search Preferences',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      _formKey.currentState!.save();
                                      context
                                          .read<SearchPreferencesCubit>()
                                          .saveData(
                                              data: SearchPrefFields()
                                                ..yearsRange = yearsRange
                                                ..distance = distance
                                                ..lookingFor = lookingFor
                                                ..gender = gender
                                                ..hobbies = hobbies
                                                ..interests = interests)
                                          .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen())));
                                    },
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child:
                                            Image.asset(CustomIcons.checkbox))),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                                'We\'ll use this information to show you people with similar interests and hobbies as you!',
                                style: TextStyle(color: Colors.black38)),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Age'),
                                Text(
                                    '${state.age!.start.round().toString()} - ${state.age!.end.round().toString()}',
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            RangeSlider(
                                values: state.age!,
                                onChanged: (newYears) {
                                  context
                                      .read<SearchPreferencesCubit>()
                                      .setAge(newYears);
                                  yearsRange = {
                                    'start': state.age!.start.round(),
                                    'end': state.age!.end.round()
                                  };
                                },
                                min: 15,
                                max: 55),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Distance'),
                                Text('${state.distance!.toString()} miles',
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            Slider(
                                value: state.distance!.toDouble(),
                                onChanged: (newDistance) {
                                  // bloc.changeDistance(newDistance.toInt());
                                  context
                                      .read<SearchPreferencesCubit>()
                                      .setDistance(newDistance.toInt());
                                  distance = newDistance.toInt();
                                },
                                min: 0,
                                max: 70),
                            reUsableWidgets.lookingForWidget(
                              context,
                              onTap: (value) {
                                context
                                    .read<SearchPreferencesCubit>()
                                    .setLookingForFields(value!);
                              },
                              lookingFor: (v) {
                                lookingFor = v;
                              },
                              // selected: state.selectedLookingForList!,
                              lookingForMap: lookingFor!,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextStyle.bigText('Gender',
                                additionalText: '(select one or more:)'),
                            const SizedBox(
                              height: 20,
                            ),
                            Ink(
                              child: Center(
                                child: DropdownButtonFormField(
                                  value: gender,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (v) {
                                    if (v == 'Gender') {
                                      return 'CHOOSE GENDER';
                                    }
                                    return null;
                                  },
                                  hint: const Text('Gender'),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp),
                                  onChanged: (v) {
                                    gender = v.toString();
                                  },
                                  decoration: genderFieldDecor('gender'),
                                  items: [
                                    DropdownMenuItem(
                                      enabled: false,
                                      value: 'Gender',
                                      child: Text(
                                        'Gender',
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                    const DropdownMenuItem(
                                      value: 'Male',
                                      child: Text(
                                        'Male',
                                      ),
                                    ),
                                    const DropdownMenuItem(
                                      value: 'Female',
                                      child: Text(
                                        "Female",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
