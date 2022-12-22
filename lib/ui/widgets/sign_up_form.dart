import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/localization/localization_cubit.dart';
import 'package:dating_app/ui/screens/login_screen.dart';
import 'package:dating_app/ui/screens/terms.dart';
import 'package:dating_app/ui/widgets/field_decor.dart';
import 'package:dating_app/ui/widgets/picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jiffy/jiffy.dart';
import '../../core/functions/validation.dart';
import '../screens/otp_verification_screen.dart';
import '../screens/profile_info_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  String verificationId = '';
  String isoCode = '';
  DateTime now = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status!.isError) {
          final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              AppLocalizations.of(context)!.userAlreadyExist,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.asset(
              Content.signUp,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.signUp,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.letsStart,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              decoration: authFieldDecor(
                                  AppLocalizations.of(context)!.fullName),
                              onSaved: (value) {
                                _nameController.text = value!.trim();
                              },
                              validator: validateNameField,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.allow(
                              //     RegExp("[a-zA-Z ]"),
                              //   ),
                              // ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            IntlPhoneField(
                              invalidNumberMessage: AppLocalizations.of(context)!.invalidPhone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,1}')),
                              ],
                              textAlign: TextAlign.center,
                              controller: _phoneController,
                              decoration: authFieldDecor(
                                  AppLocalizations.of(context)!.phoneNumber),
                              onSaved: (value) {
                                isoCode = value!.countryCode;
                                _phoneController.text = value!.number;
                                print(isoCode + _phoneController.text);
                              },
                              validator: validatePhoneField,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _dateController,
                              autocorrect: false,
                              decoration: authFieldDecor(
                                  AppLocalizations.of(context)!.dateOfBirth),
                              validator: validateDateField,
                              onTap: () async {
                                DateTime? date = DateTime(1900);
                                // DateFormat formatter = DateFormat('dd-MM-yyyy');
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                date = await Picker().birthDatePicker(context);
                                _dateController.text = Jiffy(date).yMMMMd;
                              },
                              onSaved: (value) {
                                _dateController.text = value!.trim();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: authFieldDecor('Email'),
                              validator: validateEmailField,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      isChecked = v!;
                                    });
                                  },
                                  activeColor: Colors.orange,
                                  checkColor: Colors.white,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${AppLocalizations.of(context)!.iAccept} '),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .reflowTermsConditions,
                                          style: TextStyle(
                                            color: Colors.orange[800],
                                            fontSize: 15,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TermsAndConditions()));
                                            }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: isChecked == false
                                  ? null
                                  : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      _formKey.currentState!.save();

                                      context.read<AuthCubit>().signUp(
                                          phoneNumber:
                                              isoCode + _phoneController.text,
                                          verificationId: verificationId,
                                          nav: (verId) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OtpVerificationScreen(
                                                  page: ProfileInfoScreen(
                                                    name: _nameController.text,
                                                  ),
                                                  verId: verId,
                                                  name: _nameController.text,
                                                  language: context
                                                      .read<LocalizationCubit>()
                                                      .state
                                                      .locale
                                                      .toString(),
                                                  phone: isoCode +
                                                      _phoneController.text,
                                                  date: _dateController.text,
                                                  email: _emailController.text,
                                                  joinDate: Jiffy(now).yMMMMd,
                                                  pageId: 1,
                                                ),
                                              ),
                                            );
                                          });
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
                                    AppLocalizations.of(context)!
                                        .createAccountButton,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${AppLocalizations.of(context)!.alreadyHaveAccount} ',
                                          ),
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .signInButton,
                                              style: TextStyle(
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.w500,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()));
                                                }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
