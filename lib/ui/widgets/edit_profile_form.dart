import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/ui/bloc/edit_profile_bloc.dart';
import 'package:dating_app/ui/widgets/image_picker_list.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/validation.dart';
import '../bloc/edit_profile_state.dart';
import 'field_decor.dart';

class EditProfileForm extends StatefulWidget {
  EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  String userImage = '';

  String gender = '';
  String id = '';
  String? degree;
  String? job;
  String? image;

  final nameController = TextEditingController();

  final bioController = TextEditingController();

  final heightController = TextEditingController();

  final ageController = TextEditingController();

  final universityController = TextEditingController();

  final degreeController = TextEditingController();

  final companyController = TextEditingController();

  final jobController = TextEditingController();

  final locationController = TextEditingController();

  Map<String, dynamic> hobbies = {};

  Map<String, dynamic> interests = {};
  Map<String, dynamic> lookingFor = {};

  final _formKey = GlobalKey<FormState>();

  ReUsableWidgets reUsableWidgets = ReUsableWidgets();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (BuildContext context, state) {
        if (state.status!.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        id = state.info!.id!;
        nameController.text = state.info!.name!;
        bioController.text = state.info!.bio!;
        heightController.text = state.info!.height!;
        ageController.text = state.info!.age!;
        gender = state.info!.gender!;
        job = state.info!.job!;
        degree = state.info!.degree!;
        universityController.text = state.info!.university!;
        companyController.text = state.info!.company!;
        hobbies = state.info!.hobbies!;
        interests = state.info!.interests!;
        lookingFor = state.search!.lookingFor!;
        image = state.info!.image ?? '';
        print('lookingFor 22 $lookingFor');

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImagePickerList(
                    userImage: (String s) {
                      image = s;
                    },
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
                                value: gender,
                                // validator: (v) {
                                //   if (v == null) {
                                //     return 'Choose your gender';
                                //   }
                                //   return null;
                                // },
                                hint: const Text('Gender'),
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                onChanged: (v) {
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
                                    value: 'Male',
                                    child: Text(
                                      'Male',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Female',
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                    ],
                  ),
                  reUsableWidgets.openHobbiesOrInterests(
                      context, 'Interests', hobbies),
                  reUsableWidgets.openHobbiesOrInterests(
                      context, 'Hobbies', interests),
                  reUsableWidgets.lookingForWidget(context,
                      onTap: (value) =>
                          context.read<EditProfileCubit>().changeData(value!),
                      lookingFor: (v) {
                        lookingFor = v;
                      },
                      // selected: state.selectedLookingForList!,
                      lookingForMap: lookingFor),
                  reUsableWidgets.badgeForm(
                    isRegisterForm: false,
                    isProfileInfoForm: true,
                    university: universityController,
                    company: companyController,
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState!.save();
                            context
                                .read<EditProfileCubit>()
                                .updateFields(
                                  ProfileInfoFields()
                                    ..id = id
                                    ..name = nameController.text
                                    ..bio = bioController.text
                                    ..gender = gender
                                    ..image = image
                                    ..height = heightController.text
                                    ..age = ageController.text
                                    ..degree = degree
                                    ..job = job
                                    ..hobbies = hobbies
                                    ..interests = interests
                                    ..university = universityController.text
                                    ..company = companyController.text,
                                  SearchPrefFields()..lookingFor = lookingFor,
                                )
                                .then((value) => Navigator.pop(context));

                            print('saved');
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
                                'SAVE',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
