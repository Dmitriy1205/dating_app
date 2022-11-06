import 'package:dating_app/data/models/hobbies.dart';
import 'package:dating_app/ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:dating_app/ui/widgets/image_picker_list.dart';
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

class ProfileInfoFrom extends StatefulWidget {
  const ProfileInfoFrom({Key? key}) : super(key: key);

  @override
  State<ProfileInfoFrom> createState() => _ProfileInfoFromState();
}

class _ProfileInfoFromState extends State<ProfileInfoFrom> {
  final _formKey = GlobalKey<FormState>();
  String userImage = '';
  String gender = '';
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
                                        'university': universityController.text,
                                        'degree/major': degreeController.text,
                                        'company': companyController.text,
                                        'job': jobController.text,
                                        'hobbies': hobbies,
                                        'interests': interests,
                                      });
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
                                          // value: gender,
                                          // validator: (v) {
                                          //   if (v == null) {
                                          //     return 'Choose your gender';
                                          //   }
                                          //   return null;
                                          // },
                                          hint: const Text('Gender'),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down_sharp),
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
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextStyle.bigText('Hobbies'),
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
                                          children: const [
                                            Text(
                                              'Select',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextStyle.bigText('Interests'),
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
                                          children: const [
                                            Text(
                                              'Select',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
}
