import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'field_decor.dart';

class FilterForm extends StatefulWidget {
  FilterForm({Key? key}) : super(key: key);

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  RangeValues _currentRangeValues = const RangeValues(20, 30);

  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
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
                        hint: const Text('Select'),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey[500],
                        ),
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
            ),
            const Text(
              'Shared hobbies',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
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
                        hint: const Text('Select'),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey[500],
                        ),
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
            ),
            const Text(
              'Shared interests',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
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
                        hint: const Text('Select'),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey[500],
                        ),
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
            ),
            const Text(
              'Location',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 30,
              ),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: profileFieldDecor('Location'),
              ),
            ),
            const Text(
              'SEARCH PREFERENCES',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Age'),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 20,
              ),
              child: SliderTheme(
                data: const SliderThemeData(
                  thumbColor: Colors.white,
                  activeTrackColor: Colors.deepOrangeAccent,

                ),
                child: RangeSlider(
                    max: 100,
                    min: 0,
                    divisions: 10,
                    values: _currentRangeValues,
                    inactiveColor: Colors.grey.shade200,
                    onChanged: (onChanged) {
                      setState((){
                        _currentRangeValues = onChanged;
                      });
                    }),
              ),
            ),
            const Text('Distance'),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 20,
              ),
              child: Slider(
                thumbColor: Colors.white,
                max: 100,
                min: 0,
                value: _currentSliderValue,
                activeColor: Colors.deepOrangeAccent,
                inactiveColor: Colors.grey.shade200,
                onChanged: (value) {
                  setState((){
                    _currentSliderValue = value;
                  });

                },
              ),
            ),
            const Text(
              'Gender',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
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
                        hint: const Text('Gender'),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey[500],
                        ),
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
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // isChecked == false
                  //     ? null
                  //     : () {
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
  }
}

