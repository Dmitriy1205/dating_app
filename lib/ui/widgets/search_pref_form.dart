import 'package:dating_app/core/constants.dart';
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
                                        child:
                                            Image.asset(CustomIcons.checkbox))),
                                // const Icon(
                                //   Icons.check,
                                // ),
                              ],
                            ),
                            const Text(
                                'We\'ll use this information to show you people with similar interests and hobbies as you!',
                                style: TextStyle(color: Colors.black38)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Age'),
                                Text('${bloc.rangeAge.start.round().toString()} - ${bloc.rangeAge.end.round().toString()}'),
                              ],
                            ),
                            RangeSlider(
                                values:
                                    state.age,
                                onChanged: (newYears) {
                                  bloc.changeYears(newYears);
                                  print(bloc.rangeAge);
                                },
                                // labels: RangeLabels(RangeValues(bloc.rangeAge)),
                                min: 10,
                                max: 75),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const Text('Distance'),
                                Text('${bloc.rangeDistance.toString()} miles'),

                              ],
                            ),
                            Slider(
                                value:
                                state.distance.toDouble(),
                                onChanged: (newDistance) {
                                  bloc.changeDistance(newDistance.toInt());
                                  print(bloc.rangeAge);
                                },
                                // labels: RangeLabels(RangeValues(bloc.rangeAge)),
                                min: 0,
                                max: 80),
                            Text('Looking For'),
                            CheckboxListTile(title: Text('someone to chill with'), value: false, onChanged: (_) {},)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else
          return Text('Error');
      },
    );
  }
}
