import 'package:dating_app/data/models/hobbies.dart';
import 'package:dating_app/ui/bloc/localization/localization_cubit.dart';
import 'package:dating_app/ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:dating_app/ui/widgets/image_picker_list.dart';
import 'package:dating_app/ui/widgets/location_field.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/functions/validation.dart';
import '../../core/themes/text_styles.dart';
import '../../data/models/interests.dart';
import '../screens/hobbies_screen.dart';
import '../screens/interests_screen.dart';
import '../screens/search_pref_screen.dart';
import 'field_decor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileInfoFrom extends StatefulWidget {
  final String name;
  final String date;

  const ProfileInfoFrom({
    Key? key,
    required this.name,
    required this.date,
  }) : super(key: key);

  @override
  State<ProfileInfoFrom> createState() => _ProfileInfoFromState();
}

class _ProfileInfoFromState extends State<ProfileInfoFrom> {
  final _formKey = GlobalKey<FormState>();
  double latitude = 40.416775;
  double longitude = -3.703790;
  String userImage = '';
  String gender = 'Gender';
  String status = 'status';
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final universityController = TextEditingController();
  final degreeController = TextEditingController();
  final companyController = TextEditingController();
  final jobController = TextEditingController();
  final locationController = TextEditingController();
  Map<String, dynamic> hobbies = Hobbies().toMap();

  Map<String, dynamic> interests = Interests().toMap();

  ReUsableWidgets reUsableWidgets = ReUsableWidgets();

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

        // nameController.text = widget.name;
        ageController.text = widget.date;
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(
                //       Content.profile,
                //     ),
                //     fit: BoxFit.fitWidth,
                //   ),
                // ),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const SearchPrefScreen(),
                                          ),
                                        );
                                      },
                                      splashRadius: 0.1,
                                      iconSize: 28,
                                      alignment: Alignment.topLeft,
                                      icon: const Icon(
                                        Icons.close,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.profileInfo,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    context
                                        .read<ProfileInfoCubit>()
                                        .saveData(data: {
                                      'image': userImage,
                                      'name': nameController.text,
                                      'bio': bioController.text,
                                      'gender': gender,
                                      'height': heightController.text,
                                      'age': ageController.text,
                                      'status': status,
                                      'university': universityController.text,
                                      'degree/major': degreeController.text,
                                      'company': companyController.text,
                                      'job': jobController.text,
                                      'hobbies': hobbies,
                                      'interests': interests,
                                      'location': locationController.text,
                                    });
                                  },
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset(
                                      'assets/icons/check.png',
                                    ),
                                  ),
                                ),
                                // const Icon(
                                //   Icons.check,
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ImagePickerList(
                              userImage: (i) {
                                userImage = i;

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
                                // TextFormField(
                                //   autovalidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //   autocorrect: false,
                                //   controller: nameController,
                                //   keyboardType: TextInputType.name,
                                //   decoration: profileFieldDecor(
                                //       AppLocalizations.of(context)!.name),
                                //   onSaved: (value) {
                                //     nameController.text = value!.trim();
                                //   },
                                //   validator: validateNameField,
                                //   // inputFormatters: [
                                //   //   FilteringTextInputFormatter.allow(
                                //   //     RegExp("[a-zA-Z ]"),
                                //   //   ),
                                //   // ],
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: bioController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 12,
                                  decoration: profileFieldDecor(
                                      AppLocalizations.of(context)!
                                          .tellUsAbout),
                                  onSaved: (value) {
                                    bioController.text = value!.trim();
                                  },
                                  validator: validateNameField,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Ink(
                                  child: Center(
                                    child: DropdownButtonFormField(
                                      value: gender,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (v) {
                                        if (v == 'Gender') {
                                          return AppLocalizations.of(context)!
                                              .chooseYourGender;
                                        }
                                        return null;
                                      },
                                      hint: Text(
                                          AppLocalizations.of(context)!.gender),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      onChanged: (v) {
                                        gender = v.toString();
                                      },

                                      decoration: genderFieldDecor(
                                          AppLocalizations.of(context)!.gender),
                                      // const InputDecoration(
                                      //   enabledBorder: InputBorder.none,
                                      //   focusedBorder: InputBorder.none,
                                      //   fillColor: Colors.white,
                                      //   // errorBorder: InputBorder(),
                                      // ),
                                      // decoration: profileFieldDecor('Gender'),
                                      items: [
                                        DropdownMenuItem(
                                          enabled: false,
                                          value: 'Gender',
                                          child: Text(
                                            'Gender',
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
                                            AppLocalizations.of(context)!
                                                .female,
                                          ),
                                        ),
                                      ],
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
                                          decoration: profileFieldDecor(
                                              AppLocalizations.of(context)!
                                                  .height),
                                          onSaved: (value) {
                                            heightController.text =
                                                value!.trim();
                                          },
                                          validator: validateNameField,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]"),
                                            ),
                                            FilteringTextInputFormatter.deny(
                                              RegExp(
                                                  r'^0+'), //users can't type 0 at 1st position
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
                                          decoration: profileFieldDecor(
                                              AppLocalizations.of(context)!
                                                  .age),
                                          onSaved: (value) {
                                            ageController.text = value!.trim();
                                          },
                                          validator: validateNameField,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp("[0-9]"),
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
                                Ink(
                                  child: Center(
                                    child: DropdownButtonFormField(
                                      hint: Text(AppLocalizations.of(context)!
                                          .relationship),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      onChanged: (v) {
                                        status = v.toString();
                                      },
                                      decoration: genderFieldDecor(
                                          AppLocalizations.of(context)!.status),
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Single',
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .single,
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Married',
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .married,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                LocationField(
                                  locationController: locationController,
                                  latitude: longitude,
                                  longitude: longitude,
                                  func: (value) {
                                    locationController.text = value;
                                  },
                                  language: context
                                      .read<LocalizationCubit>()
                                      .state
                                      .locale
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                registerForm(),
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
                                      context.read<ProfileInfoCubit>().init();
                                    }
                                  },
                                  child: Ink(
                                    color: Colors.white,
                                    child: Container(
                                      height: 57,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 19),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .selects,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
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
                                    (index) => hobbies.values
                                                .elementAt(index) ==
                                            false
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(right: 6),
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
                                      context.read<ProfileInfoCubit>().init();
                                    }
                                  },
                                  child: Ink(
                                    color: Colors.white,
                                    child: Container(
                                      height: 57,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 19),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .selects,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
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
                                    (index) => interests.values
                                                .elementAt(index) ==
                                            false
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(right: 6),
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

  Widget registerForm() {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: universityController,
          keyboardType: TextInputType.name,
          decoration:
              profileFieldDecor(AppLocalizations.of(context)!.university),
          onSaved: (value) {
            universityController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: degreeController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor(AppLocalizations.of(context)!.degree),
          onSaved: (value) {
            degreeController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: companyController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor(AppLocalizations.of(context)!.company),
          onSaved: (value) {
            companyController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          controller: jobController,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor(AppLocalizations.of(context)!.job),
          onSaved: (value) {
            jobController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
      ],
    );
  }
}
