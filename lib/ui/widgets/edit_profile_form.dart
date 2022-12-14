import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/ui/bloc/edit_profile_bloc.dart';
import 'package:dating_app/ui/widgets/image_picker_list.dart';
import 'package:dating_app/ui/widgets/location_field.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/functions/validation.dart';
import '../bloc/edit_profile_state.dart';
import 'field_decor.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  String address = 's';
  String userImage = '';
  double latitude = 40.416775;
  double longitude = -3.703790;

  String gender = '';
  String id = '';
  String? degree;
  String? job;
  String? image;
  String? status;

  final nameController = TextEditingController();

  final bioController = TextEditingController();

  final heightController = TextEditingController();

  final ageController = TextEditingController();

  final universityController = TextEditingController();

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
        var search = state.userModel!.searchPref!;
        var profile = state.userModel!.profileInfo!;
        // longitude = state.userModel.longitude;
        // latitude = state.userModel.latitude;
        locationController.text = profile!.location!;
        nameController.text = profile.name!;
        bioController.text = profile.bio!;
        heightController.text = profile.height!;
        ageController.text = profile.age!;
        gender = profile.gender!;
        jobController.text = profile.job!;
        degree = profile.degree!;
        job = profile.job!;
        status = profile.status!;
        universityController.text = profile.university!;
        companyController.text = profile.company!;
        hobbies = profile.hobbies!;
        interests = profile.interests!;
        image = profile.image!;
        lookingFor = search.lookingFor!;
        // id = state.info!.id!;
        // nameController.text = state.profileInfo!.name!;
        // bioController.text = state.profileInfo!.bio!;
        // heightController.text = state.profileInfo!.height!;
        // ageController.text = state.profileInfo!.age!;
        // gender = state.profileInfo!.gender!;
        // job = state.profileInfo!.job!;
        // degree = state.profileInfo!.degree!;
        // universityController.text = state.profileInfo!.university!;
        // companyController.text = state.profileInfo!.company!;
        // hobbies = state.profileInfo!.hobbies!;
        // interests = state.profileInfo!.interests!;
        // lookingFor = state.searchPref!.lookingFor!;
        // image = state.profileInfo!.image ?? '';
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
                      return image = s;
                      // print(image);
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        AppLocalizations.of(context)!.general,
                        style: const TextStyle(
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
                        decoration: profileFieldDecor(
                            AppLocalizations.of(context)!.name),
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
                        decoration: profileFieldDecor(
                            AppLocalizations.of(context)!.tellUsAbout),
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
                                hint:
                                    Text(AppLocalizations.of(context)!.gender),
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
                                items: [
                                  DropdownMenuItem(
                                    value: 'Male',
                                    child: Text(
                                      AppLocalizations.of(context)!.male,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Female',
                                    child: Text(
                                      AppLocalizations.of(context)!.female,
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
                                decoration: profileFieldDecor(
                                    AppLocalizations.of(context)!.height),
                                onSaved: (value) {
                                  heightController.text = value!.trim();
                                },
                                validator: validateNameField,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'^0+'), //users can't type 0 at 1st position
                                  ), //users can't type 0 at 1st position

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
                                decoration: profileFieldDecor(
                                    AppLocalizations.of(context)!.age),
                                onSaved: (value) {
                                  ageController.text = value!.trim();
                                },
                                validator: validateNameField,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'^0+'), //users can't type 0 at 1st position
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
                      LocationField(
                        locationController: locationController,
                        latitude: latitude,
                        longitude: longitude,
                        language: state.userModel!.language,
                        func: (value) {
                          locationController.text = value;
                        },
                      ),
                    ],
                  ),
                  reUsableWidgets.openHobbiesOrInterests(context,
                      AppLocalizations.of(context)!.interests, interests),
                  reUsableWidgets.openHobbiesOrInterests(
                      context, AppLocalizations.of(context)!.hobbies, hobbies),
                  reUsableWidgets.lookingForWidget(context,
                      onTap: (value) =>
                          context.read<EditProfileCubit>().changeData(value!),
                      lookingFor: (v) {
                        lookingFor = v;
                      },
                      // selected: state.selectedLookingForList!,
                      lookingForMap: lookingFor),
                  const SizedBox(
                    height: 20,
                  ),
                  reUsableWidgets.badgeForm(
                    context,
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
                                .update(
                                    ProfileInfoFields()
                                      ..name = nameController.text
                                      ..bio = bioController.text
                                      ..gender = gender
                                      ..image = image
                                      ..height = heightController.text
                                      ..age = ageController.text
                                      ..degree = degree
                                      ..status = status
                                      ..job = job
                                      ..hobbies = hobbies
                                      ..interests = interests
                                      ..university = universityController.text
                                      ..company = companyController.text
                                      ..location = locationController.text,
                                    lookingFor = lookingFor)
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
                              child: Text(
                                AppLocalizations.of(context)!.save,
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
