import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants.dart';
import '../../core/functions/validation.dart';
import '../screens/hobbies_screen.dart';
import '../screens/interests_screen.dart';
import '../screens/search_pref_screen.dart';
import 'field_decor.dart';

class ProfileInfoFrom extends StatefulWidget {
  const ProfileInfoFrom({Key? key}) : super(key: key);

  @override
  State<ProfileInfoFrom> createState() => _ProfileInfoFromState();
}

class _ProfileInfoFromState extends State<ProfileInfoFrom> {
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
  File? _image;

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Content.profile,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Form(
                    key: _formKey,
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
                                const Text(
                                  'Profile Info',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPrefScreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child:
                                        Image.asset('assets/icons/check.png'))),
                            // const Icon(
                            //   Icons.check,
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 230,
                          width: double.infinity,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 150,
                                child: GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset(
                                              'assets/icons/photo.png')),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              //TODO: add horizontal lisview.builder to make row of pictures from storage
                              const SizedBox(
                                height: 200,
                                width: 150,
                                child: Card(
                                  elevation: 5,
                                  child: Center(),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                height: 200,
                                width: 150,
                                child: Card(
                                  elevation: 5,
                                  child: Center(),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          decoration:
                              profileFieldDecor('Tell us about yourself'),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19),
                              child: Center(
                                child: DropdownButtonFormField(
                                  hint: const Text('Gender'),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp),
                                  onChanged: (v) {},
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder:InputBorder.none ,
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
                            SizedBox(
                              width: 170,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                            SizedBox(
                              width: 170,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                        const SizedBox(
                          height: 20,
                        ),
                        //TODO: change this formfield to button with choosing a hobbies Chip() widget
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HobbiesScreen()));
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Hobbies',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InterestsScreen()));
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Interests',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
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
    );
  }

  void submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    print(_nameController.text);
    print(_bioController.text);
    print(_heightController.text);
    print(_ageController.text);
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
  }

  Future imageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // print('No image selected.');
      }
    });
  }

  Future imageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 400,
      imageQuality: 100,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No photo selected.');
      }
    });
  }

  void _showPicker(context) {
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
}
