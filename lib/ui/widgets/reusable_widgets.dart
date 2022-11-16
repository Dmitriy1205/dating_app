import 'dart:io';

import 'package:dating_app/ui/screens/hobbies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/functions/validation.dart';
import '../../core/themes/checkboxes.dart';
import '../../core/themes/text_styles.dart';
import '../screens/interests_screen.dart';
import 'field_decor.dart';

class ReUsableWidgets {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  bool isChecked = false;
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final companyController = TextEditingController();
  final jobController = TextEditingController();
  final locationController = TextEditingController();



  Widget customGradientButton(BuildContext context, {required String text}) {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
          onPressed: () {
            switch (text) {
              case 'SIGN IN':
                {
                  submit(context);
                }
                break;
              case 'SAVE':
                {

                }
            }

            text == 'SIGN IN' ? submit(context) : null;
            //TODO: navigation to profile
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
                text,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }

  void submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    const snackBar = SnackBar(
      backgroundColor: Colors.teal,
      content: Text(
        'Success',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => OtpVerificationScreen()));
  }

  Widget lookingForWidget(
    BuildContext context, {
    required Function(String?) onTap,
    // required List<String> selected,
    Function(Map<String, dynamic>)? lookingFor,
    Map<String, dynamic>? lookingForMap,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextStyle.bigText('Looking For',
            additionalText: '(select one or more:)'),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lookingForMap!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: lookingForMap.values.elementAt(index)
                              ? Colors.orangeAccent
                              : Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: ListTile(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(25, 5, 10, 5),
                                dense: true,
                                title: Text(
                                  lookingForMap.keys.elementAt(index),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                      color: Colors.black54),
                                ),
                                trailing:
                                        lookingForMap.values.elementAt(index)
                                    ? CustomCheckbox.checked()
                                    : const SizedBox(),
                                onTap: () {
                                  onTap(lookingForMap.keys.elementAt(index));

                                  lookingForMap.update(
                                      lookingForMap.keys.elementAt(index),
                                      (value) => !value);
                                  print(lookingForMap);
                                  lookingFor!(lookingForMap);
                                }),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }

  Widget generalInfoEditWidget(String registerOrEditInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          'General',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Name'),
          onSaved: (value) {
            nameController.text = value!.trim();
          },
          validator: validateNameField,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp("[a-zA-Z ]"),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: bioController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: profileFieldDecor('Tell us about yourself'),
          onSaved: (value) {
            bioController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        Ink(
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
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
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
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: profileFieldDecor('Height'),
                  onSaved: (value) {
                    heightController.text = value!.trim();
                  },
                  validator: validateNameField,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[0-9]"),
                    ),
                    LengthLimitingTextInputFormatter(3),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: SizedBox(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: profileFieldDecor('Age'),
                  onSaved: (value) {
                    ageController.text = value!.trim();
                  },
                  validator: validateNameField,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[0-9]"),
                    ),
                    LengthLimitingTextInputFormatter(2),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        switchCase(registerOrEditInfo)
      ],
    );
  }

  switchCase(registerOrEditInfo) {
    switch (registerOrEditInfo) {
      case 'register':
        return badgeForm(
          isRegisterForm: true,
          isProfileInfoForm: false,
        );
      case 'edit':
        return editForm();
      case 'profile info':
        return badgeForm(isRegisterForm: true, isProfileInfoForm: false);
    }
  }

  Widget editForm() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      controller: locationController,
      keyboardType: TextInputType.name,
      decoration: profileFieldDecor('Location'),
      onSaved: (value) {
        locationController.text = value!.trim();
      },
      validator: validateNameField,
    );
  }

  Widget badgeForm({
    required bool isRegisterForm,
    required bool isProfileInfoForm,
    TextEditingController? university,
    TextEditingController? company,
  }) {
    return Column(
      children: [
        if (isProfileInfoForm)
          Column(children: [
            CustomTextStyle.bigText('Badge'),
            const SizedBox(
              height: 20,
            ),
          ]),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: university,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('University'),
          onSaved: (value) {
            universityController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 10,
        ),
        if (isRegisterForm)
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            controller: degreeController,
            keyboardType: TextInputType.name,
            decoration: profileFieldDecor('Degree/Major'),
            onSaved: (value) {
              degreeController.text = value!.trim();
            },
            validator: validateNameField,
          ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: company,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Company'),
          onSaved: (value) {
            companyController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 10,
        ),
        if (isRegisterForm)
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            controller: jobController,
            keyboardType: TextInputType.name,
            decoration: profileFieldDecor('Job Title'),
            onSaved: (value) {
              jobController.text = value!.trim();
            },
            validator: validateNameField,
          ),
      ],
    );
  }

  Widget openHobbiesOrInterests(
      BuildContext context, String component, Map<String, dynamic>? fields) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextStyle.bigText(component),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => component == 'Interests'
                        ? InterestsScreen(
                            interests: fields,
                          )
                        : HobbiesScreen(
                            hobbies: fields,
                          )));
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10.0)),
            child: SizedBox(
              height: 57,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Select',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showPicker(BuildContext context,
      {required void Function(File? f) func}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        const ListTile(
                          title: Center(
                            child: Text(
                              'Choose your image',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        ListTile(
                            title: const Center(
                              child: Text(
                                'Photo',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onTap: () {
                              imageFromCamera(getPhoto: (File? f) {
                                func(f);
                              });
                              Navigator.of(context).pop();
                            }),
                        const Divider(
                          thickness: 2,
                        ),
                        ListTile(
                            title: const Center(
                              child: Text(
                                'Image from files',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onTap: () {
                              imageFromGallery(getImage: (File? f) {
                                func(f);
                              });
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                            title: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            )),
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future imageFromGallery({required Function(File?) getImage}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getImage(_image!);
    } else {
      // print('No image selected.');
    }
  }

  Future imageFromCamera({required Function(File?) getPhoto}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getPhoto(_image!);
    } else {
      // print('No image selected.');
    }
  }
}
