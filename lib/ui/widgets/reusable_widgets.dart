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

  Map<String, bool> lookingForMap = {
    'someone to chill with': false,
    'a friend': false,
    'a romantic partner': false,
    'a business partner': false,
    'a mentor': false,
    'a mentee': false
  };

  List<String> selectedLookingFor = [];

  Widget lookingForWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextStyle.bigText('Looking For',
              additionalText: '(select one or more:)'),
          const SizedBox(
            height: 20,
          ),
          Wrap(children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lookingForMap.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
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
                                  const EdgeInsets.fromLTRB(25, 10, 10, 10),
                              dense: true,
                              title: Text(
                                lookingForMap.keys.elementAt(index),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.5,
                                    color: Colors.black54),
                              ),
                              trailing: lookingForMap.values.elementAt(index)
                                  ? CustomCheckbox.checked()
                                  : null,
                              onTap: () {}),
                        )
                      ],
                    ),
                  );
                }),
          ]),
        ],
      ),
    );
  }

  Widget generalInfoEditWidget(String registerOrEditInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Column(
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
          registerOrEditInfo == 'register' ? registerForm() : editForm()
        ],
      ),
    );
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

  Widget registerForm() {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: universityController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('University'),
          onSaved: (value) {
            universityController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
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
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: companyController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Company'),
          onSaved: (value) {
            companyController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
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

  Widget openHobbiesOrInterests(BuildContext context, String component) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextStyle.bigText(component),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => component == 'Interests'
                          ? const InterestsScreen()
                          : const HobbiesScreen()));
            },
            child: Ink(
              color: Colors.white,
              child: Container(
                height: 57,
                width: 400,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10.0)),
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
      ),
    );
  }

  void showPicker(BuildContext context) {
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
                                'Image from files',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            onTap: () {
                              imageFromCamera();
                              Navigator.of(context).pop();
                            }),
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
                              imageFromGallery();
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

  Future imageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );
  }

  Future imageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );
  }
}
