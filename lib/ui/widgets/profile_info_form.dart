import 'dart:io';

import 'package:dating_app/ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants.dart';
import '../../core/functions/validation.dart';
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
  File? _image;
  int _itemCount = 0;
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final companyController = TextEditingController();
  final jobController = TextEditingController();
  final locationController = TextEditingController();

  // ReUsableWidgets reUsableWidgets = ReUsableWidgets();

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   bioController.dispose();
  //   heightController.dispose();
  //   ageController.dispose();
  //   universityController.dispose();
  //   degreeController.dispose();
  //   companyController.dispose();
  //   jobController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
      listener: (context, state) {
        if (state.status!.isLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPrefScreen(),
            ),
          );
        } else if (state.status!.isError) {
          const snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
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
                                      context.read<ProfileInfoCubit>().saveData(
                                          data: {
                                            'name': nameController.text,
                                            'bio': bioController.text,
                                            'gender': 'gender',
                                            'height': heightController.text,
                                            'age': ageController.text,
                                            'university':
                                                universityController.text,
                                            'degree/major':
                                                degreeController.text,
                                            'company': companyController.text,
                                            'job': jobController.text,
                                          }
                                          // ProfileInfoData()
                                          //   ..name = nameController.text
                                          //   ..bio = bioController.text
                                          //   ..gender = 'male'
                                          //   ..height = heightController.text
                                          //   ..company = companyController.text
                                          //   ..age = ageController.text
                                          //   ..university = universityController.text
                                          //   ..degree = degreeController.text
                                          //   ..job = jobController.text
                                          );
                                    },
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                            'assets/icons/check.png'))),
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
                                        showPicker(
                                          context,
                                          func: (File? f) {
                                            context
                                                .read<ProfileInfoCubit>()
                                                .uploadImage(
                                                    f!, '${_itemCount++}');
                                          },
                                        );
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
                            Column(
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: bioController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  decoration: profileFieldDecor(
                                      'Tell us about yourself'),
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
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19),
                                      child: Center(
                                        child: DropdownButtonFormField(
                                          hint: const Text('Gender'),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          autocorrect: false,
                                          controller: heightController,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              profileFieldDecor('Height'),
                                          onSaved: (value) {
                                            heightController.text =
                                                value!.trim();
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                registerForm(),
                              ],
                            ),
                            // reUsableWidgets.openHobbiesOrInterests(
                            //     context, 'Hobbies'),
                            // reUsableWidgets.openHobbiesOrInterests(
                            //     context, 'Interests'),
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
      },
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
                                'Image from files',
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
                                'Photo',
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
    } else {
      // print('No image selected.');
    }
    getImage(_image!);
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
// void submit(context) {
//   if (!_formKey.currentState!.validate()) return;
//   _formKey.currentState!.save();
//   const snackBar = SnackBar(
//     backgroundColor: Colors.teal,
//     content: Text(
//       'Success',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//   );
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
}
