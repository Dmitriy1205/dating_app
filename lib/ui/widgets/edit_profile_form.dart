import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/ui/bloc/edit_profile_bloc.dart';
import 'package:dating_app/ui/widgets/image_picker_list.dart';
import 'package:dating_app/ui/widgets/loading_indicator.dart';
import 'package:dating_app/ui/widgets/location_field.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/functions/validation.dart';
import '../../core/themes/text_styles.dart';
import '../bloc/edit_profile_state.dart';
import '../screens/hobbies_screen.dart';
import '../screens/interests_screen.dart';
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
          return const LoadingIndicator();

        }
        List<String> inter = [
          AppLocalizations.of(context)!.photography,
          AppLocalizations.of(context)!.acting,
          AppLocalizations.of(context)!.film,
          AppLocalizations.of(context)!.finArt,
          AppLocalizations.of(context)!.music,
          AppLocalizations.of(context)!.fashion,
          AppLocalizations.of(context)!.dance,
          AppLocalizations.of(context)!.politics,
        ];
        List<String> hobb = [
          AppLocalizations.of(context)!.workingOut,
          AppLocalizations.of(context)!.reading,
          AppLocalizations.of(context)!.cooking,
          AppLocalizations.of(context)!.biking,
          AppLocalizations.of(context)!.drinking,
          AppLocalizations.of(context)!.shopping,
          AppLocalizations.of(context)!.hiking,
          AppLocalizations.of(context)!.baking,
        ];
        var search = state.userModel!.searchPref!;
        var profile = state.userModel!.profileInfo!;
        locationController.text = profile.location!;
        nameController.text = state.userModel!.firstName!;
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

                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            child: Center(
                              child: DropdownButtonFormField(
                                value: gender,
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (v) {
                                //   if (v == 'Gender') {
                                //     return AppLocalizations.of(context)!
                                //         .chooseGender;
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
                                  errorBorder:InputBorder.none ,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      fillColor: Colors.white,
                                    ),
                                items: [
                                  DropdownMenuItem(
                                    enabled: false,
                                    value: 'Gender',
                                    child: Text(
                                      AppLocalizations.of(context)!.gender,
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
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
                              // DropdownButtonFormField(
                              //   value: gender,
                              //   // validator: (v) {
                              //   //   if (v == null) {
                              //   //     return 'Choose your gender';
                              //   //   }
                              //   //   return null;
                              //   // },
                              //   hint:
                              //       Text(AppLocalizations.of(context)!.gender),
                              //   icon:
                              //       const Icon(Icons.keyboard_arrow_down_sharp),
                              //   onChanged: (v) {
                              //     gender = v.toString();
                              //   },
                              //
                              //   decoration: const InputDecoration(
                              //     enabledBorder: InputBorder.none,
                              //     focusedBorder: InputBorder.none,
                              //     fillColor: Colors.white,
                              //   ),
                              //   // decoration: profileFieldDecor('Gender'),
                              //   items: [
                              //     DropdownMenuItem(
                              //       value: 'Male',
                              //       child: Text(
                              //         AppLocalizations.of(context)!.male,
                              //       ),
                              //     ),
                              //     DropdownMenuItem(
                              //       value: 'Female',
                              //       child: Text(
                              //         AppLocalizations.of(context)!.female,
                              //       ),
                              //     ),
                              //   ],
                              // ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextStyle.bigText(
                          AppLocalizations.of(context)!.interests),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InterestsScreen(
                                interests: interests,
                              ),
                            ),
                          );
                          interests = result;

                          if (mounted) {
                            context.read<EditProfileCubit>().start();
                          }
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.selects,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          interests.length,
                          (index) => interests.values.elementAt(index) == false
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Chip(
                                    label: Text(
                                      inter[index],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                        ).toList(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextStyle.bigText(
                          AppLocalizations.of(context)!.hobbies),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HobbiesScreen(
                                hobbies: hobbies,
                              ),
                            ),
                          );
                          hobbies = result;
                          if (mounted) {
                            context.read<EditProfileCubit>().start();
                          }
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.selects,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          hobbies.length,
                          (index) => hobbies.values.elementAt(index) == false
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Chip(
                                    label: Text(
                                      hobb[index],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                        ).toList(),
                      ),
                    ],
                  ),
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
                                    lookingFor = lookingFor,
                                    nameController.text)
                                .then((value) => Navigator.pop(context));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
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
