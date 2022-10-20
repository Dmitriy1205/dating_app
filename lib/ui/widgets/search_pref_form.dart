import 'package:dating_app/core/constants.dart';
import 'package:dating_app/core/themes/checkboxes.dart';
import 'package:dating_app/core/themes/text_styles.dart';
import 'package:dating_app/ui/bloc/search_preferances_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPrefForm extends StatefulWidget {
  const SearchPrefForm({Key? key}) : super(key: key);

  @override
  State<SearchPrefForm> createState() => _SearchPrefFormState();
}

class _SearchPrefFormState extends State<SearchPrefForm> {
  final SearchPreferancesCubit bloc = SearchPreferancesCubit();
  Map<String, bool> lookingForMap = {
    'someone to chill with': false,
    'a friend': false,
    'a romantic partner': false,
    'a business partner': false,
    'a mentor': false,
    'a mentee': false
  };
  final List<String> gender = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPreferancesCubit, SearchPreferancesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is SearchPreferenceChangeState) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          'Search Preferances',
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
                                          //TODO: submit all data and navigate to home page
                                        },
                                        child: SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                                CustomIcons.checkbox))),
                                    // const Icon(
                                    //   Icons.check,
                                    // ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Age'),
                                    Text(
                                        '${bloc.rangeAge.start.round().toString()} - ${bloc.rangeAge.end.round().toString()}',
                                        style: const TextStyle(
                                            color: Colors.black45)),
                                  ],
                                ),
                                RangeSlider(
                                    values: state.age,
                                    onChanged: (newYears) {
                                      bloc.changeYears(newYears);
                                      print(bloc.rangeAge);
                                    },
                                    min: 15,
                                    max: 55),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Distance'),
                                    Text(
                                        '${bloc.rangeDistance.toString()} miles',
                                        style: const TextStyle(
                                            color: Colors.black45)),
                                  ],
                                ),
                                Slider(
                                    value: state.distance.toDouble(),
                                    onChanged: (newDistance) {
                                      bloc.changeDistance(newDistance.toInt());
                                    },
                                    min: 0,
                                    max: 70),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextStyle.bigText('Looking For',
                                    additionalText: '(select one or more:)'),
                                Wrap(children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: lookingForMap.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: lookingForMap.values
                                                      .elementAt(index)
                                                  ? Colors.orangeAccent
                                                  : Colors.black12,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              GestureDetector(
                                                child: ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 10, 10, 10),
                                                  dense: true,
                                                  title: Text(
                                                    lookingForMap.keys
                                                        .elementAt(index),
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        letterSpacing: 0.5,
                                                        color: Colors.black54),
                                                  ),
                                                  trailing: lookingForMap.values
                                                          .elementAt(index)
                                                      ? CustomCheckbox.checked()
                                                      : null,
                                                  onTap: () {
                                                    lookingForMap.update(
                                                        lookingForMap.keys
                                                            .elementAt(index),
                                                        (value) => !value);
                                                    if (lookingForMap.values
                                                        .elementAt(index)) {
                                                      bloc.selectLookingFor(
                                                          lookingForMap.keys
                                                              .elementAt(
                                                                  index));
                                                    } else {
                                                      bloc.deSelectLookingFor(
                                                          lookingForMap.keys
                                                              .elementAt(
                                                                  index));
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextStyle.bigText('Gender',
                                    additionalText: '(select one or more:)'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Ink(
                                  child: Container(
                                    height: 57,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19),
                                      child: Center(
                                        child: DropdownButtonFormField(
                                          hint: const Text('Select'),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down_sharp),
                                          onChanged: (v) {},
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            fillColor: Colors.white,
                                          ),
                                          // decoration: profileFieldDecor('Gender'),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "MALE",
                                              child: Text(
                                                "Male",
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "FEMALE",
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
                              ]),
                        ),
                      ]),
                )
              ],
            ),
          );
        } else {
          return const Text('Error');
        }
      },
    );
  }

// void itemChange(bool val, int index) {
//   setState(() {
//     lookingForList = val;
//   });
// }
}
