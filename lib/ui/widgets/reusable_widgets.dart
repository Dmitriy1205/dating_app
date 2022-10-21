import 'package:dating_app/ui/screens/hobbies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/functions/validation.dart';
import '../../core/themes/text_styles.dart';
import '../screens/interests_screen.dart';
import 'field_decor.dart';

class ReUsableWidgets {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _universityController = TextEditingController();
  final _degreeController = TextEditingController();
  final _companyController = TextEditingController();
  final _jobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    _universityController.dispose();
    _degreeController.dispose();
    _companyController.dispose();
    _jobController.dispose();
  }

  Widget generalInfoEditWidget() {
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
          controller: _nameController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Name'),
          onSaved: (value) {
            _nameController.text = value!.trim();
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
          controller: _bioController,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: profileFieldDecor('Tell us about yourself'),
          onSaved: (value) {
            _bioController.text = value!.trim();
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
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: profileFieldDecor('Height'),
                  onSaved: (value) {
                    _heightController.text = value!.trim();
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
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: profileFieldDecor('Age'),
                  onSaved: (value) {
                    _ageController.text = value!.trim();
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
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: _universityController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('University'),
          onSaved: (value) {
            _universityController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: _degreeController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Degree/Major'),
          onSaved: (value) {
            _degreeController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: _companyController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Company'),
          onSaved: (value) {
            _companyController.text = value!.trim();
          },
          validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: _jobController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor('Job Title'),
          onSaved: (value) {
            _jobController.text = value!.trim();
          },
          validator: validateNameField,
        ),
      ],
    );
  }

  Widget openHobbiesOrInterestst(BuildContext context, String component) {
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
              width: 350,
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
