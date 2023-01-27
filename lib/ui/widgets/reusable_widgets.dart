import 'dart:io';

import 'package:dating_app/ui/screens/hobbies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/functions/validation.dart';
import '../../core/themes/checkboxes.dart';
import '../../core/themes/text_styles.dart';
import '../bloc/messenger_cubit.dart';
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
                {}
            }

            text == AppLocalizations.of(context)!.signInButton
                ? submit(context)
                : null;
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
    List<String> lookin = [
      AppLocalizations.of(context)!.aMentee,
      AppLocalizations.of(context)!.aFriend,
      AppLocalizations.of(context)!.someoneToChillWith,
      AppLocalizations.of(context)!.aRomanticPartner,
      AppLocalizations.of(context)!.aBusinessPartner,
      AppLocalizations.of(context)!.aMentor,
    ];
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomTextStyle.bigText(AppLocalizations.of(context)!.lookingFor,
            additionalText:
                '(${AppLocalizations.of(context)!.selectOneOrMore}:)'),
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
                                  lookin[index],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                      color: Colors.black54),
                                ),
                                trailing: lookingForMap.values.elementAt(index)
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

  Widget generalInfoEditWidget(
      BuildContext context, String registerOrEditInfo) {
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
        switchCase(context, registerOrEditInfo)
      ],
    );
  }

  switchCase(BuildContext context, registerOrEditInfo) {
    switch (registerOrEditInfo) {
      case 'register':
        return badgeForm(
          context,
          isRegisterForm: true,
          isProfileInfoForm: false,
        );
      case 'edit':
        return editForm();
      case 'profile info':
        return badgeForm(context,
            isRegisterForm: true, isProfileInfoForm: false);
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

  Widget badgeForm(
    BuildContext context, {
    required bool isRegisterForm,
    required bool isProfileInfoForm,
    TextEditingController? university,
    TextEditingController? company,
  }) {
    return Column(
      children: [
        if (isProfileInfoForm)
          Column(children: [
            CustomTextStyle.bigText(AppLocalizations.of(context)!.badge),
            const SizedBox(
              height: 20,
            ),
          ]),
        TextFormField(

          autocorrect: false,
          controller: university,
          keyboardType: TextInputType.name,
          decoration:
              profileFieldDecor(AppLocalizations.of(context)!.university),
          onSaved: (value) {
            universityController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
        const SizedBox(
          height: 10,
        ),
        if (isRegisterForm)
          TextFormField(

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
          height: 10,
        ),
        TextFormField(

          autocorrect: false,
          controller: company,
          keyboardType: TextInputType.name,
          decoration: profileFieldDecor(AppLocalizations.of(context)!.company),
          onSaved: (value) {
            companyController.text = value!.trim();
          },
          // validator: validateNameField,
        ),
        const SizedBox(
          height: 10,
        ),
        if (isRegisterForm)
          TextFormField(
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
  static showToast(
      {required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
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
                    builder: (context) => component == 'Interests' ||
                            component == 'Intereses' ||
                            component == 'Intérêts' ||
                            component == 'Interesses'
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
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selects,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
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
              alignment: WrapAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.chooseYourImage,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        ListTile(
                            title: Center(
                              child: Text(
                                AppLocalizations.of(context)!.photo,
                                style: const TextStyle(
                                  color: Colors.orangeAccent,
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
                          thickness: 1,
                        ),
                        ListTile(
                            title: Center(
                              child: Text(
                                AppLocalizations.of(context)!.imageFromFiles,
                                style: const TextStyle(
                                  color: Colors.orangeAccent,
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
                  padding: const EdgeInsets.only(left: 22,right: 22,bottom: 22),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                          AppLocalizations.of(context)!.cancel.toUpperCase(),
                        ),
                      ),
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
      maxWidth: 480,
      maxHeight: 640,
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
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getPhoto(_image!);
    } else {
      // print('No image selected.');
    }
  }

  static Padding buildExpansionList(
    BuildContext context,
    Map<String, dynamic>? inputFields, {
    required Function(String?) onTap,
    Function(Map<String, dynamic>)? set,
    required List<String> names,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Center(
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  AppLocalizations.of(context)!.selects,
                  style: TextStyle(color: Colors.grey),
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: inputFields!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onTap(inputFields.keys.elementAt(index));

                            inputFields.update(
                                inputFields.keys.elementAt(index),
                                (value) => !value);
                            print(inputFields.values);
                            set!(inputFields);
                          },
                          child: SizedBox(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: inputFields.values.elementAt(index)
                                      ? Colors.orangeAccent
                                      : Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      names[index],
                                      style: TextStyle(
                                          color: inputFields.values
                                                      .elementAt(index) ==
                                                  false
                                              ? Colors.black
                                              : Colors.orange),
                                    ),
                                    SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: inputFields.values
                                                    .elementAt(index) ==
                                                false
                                            ? const SizedBox()
                                            : Image.asset(
                                                'assets/icons/check.png')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            // DropdownButtonFormField(
            //   // value: lookingFor.length,
            //   hint: const Text('Select'),
            //
            //   icon: Icon(
            //     Icons.keyboard_arrow_down_sharp,
            //     color: Colors.grey[500],
            //   ),
            //   onChanged: (v) {},
            //   decoration: const InputDecoration(
            //     enabledBorder: InputBorder.none,
            //     focusedBorder: InputBorder.none,
            //     fillColor: Colors.white,
            //   ),
            //   // decoration: profileFieldDecor('Gender'),
            //   items: List.generate(
            //       lookingFor.length,
            //       (index) => DropdownMenuItem(
            //             value: lookingFor.keys.elementAt(index),
            //             child: Row(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   lookingFor.keys.elementAt(index),
            //                 ),
            //                 Icon(Icons.add),
            //               ],
            //             ),
            //           )),
            // ),
          ),
        ),
      ),
    );
  }
 static showBlockDialog(BuildContext context, String userName, String userId) {
    Widget noButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 110,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.no,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // );
    Widget yesButton = ElevatedButton(
      onPressed: () {
        BlocProvider.of<MessengerCubit>(context)
            .blockUser(userId)
            .then((value) => Navigator.pop(context));
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 110,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.yes,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                '${AppLocalizations.of(context)!.areYouSureBlock}\n$userName',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            actions: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    noButton,
                    yesButton,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

 static showUnfriendDialog(BuildContext context, String userName, String userId) {
    Widget noButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 110,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.no,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // );
    Widget yesButton = ElevatedButton(
      onPressed: () {
        //Todo: unfriend
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 110,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.yes,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Text(
                '${AppLocalizations.of(context)!.youSureUnfriend}\n$userName',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            actions: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    noButton,
                    yesButton,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showReportDialog(BuildContext context, String userName, String userId) {
    Widget noButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 120,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.ok,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // );
    Widget yesButton = ElevatedButton(
      onPressed: () {
        //Todo: send report
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
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
          width: 120,
          height: 35,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 1,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.whyYouWantReport,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: TextFormField(
                        autocorrect: false,
                        // controller: bioController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: profileFieldDecor(
                            AppLocalizations.of(context)!.writeHere),
                        //   onSaved: (value) {
                        //     bioController.text = value!.trim();
                        //   },
                        //   validator: validateNameField,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    noButton,
                    yesButton,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
