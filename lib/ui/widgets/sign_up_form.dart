import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/screens/login_screen.dart';
import 'package:dating_app/ui/screens/profile_info_screen.dart';
import 'package:dating_app/ui/widgets/field_decor.dart';
import 'package:dating_app/ui/widgets/picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../core/functions/validation.dart';

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
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image.asset(
          Background.signUp,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Let\'s get you started',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: authFieldDecor('Full Name'),
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
                        InternationalPhoneNumberInput(
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorConfig: const SelectorConfig(
                            setSelectorButtonAsPrefixIcon: true,
                            // leadingPadding: 20,
                            useEmoji: true,
                          ),
                          textFieldController: _phoneController,
                          onInputChanged: (phone) {
                            phone.phoneNumber!;
                          },
                          onSaved: (value) {
                            _phoneController.text = value.phoneNumber!;
                          },
                          formatInput: false,
                          inputDecoration: authFieldDecor('Phone Number'),
                          selectorTextStyle: TextStyle(
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                          selectorButtonOnErrorPadding: 0,
                          validator: validatePhoneField,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _dateController,
                          autocorrect: false,
                          decoration: authFieldDecor('Date of Birth'),
                          validator: validateDateField,
                          onTap: () async {
                            DateTime? date = DateTime(1900);
                            DateFormat formatter = DateFormat('dd-MM-yyyy');
                            FocusScope.of(context).requestFocus(FocusNode());
                            date = await Picker().birthDatePicker(context);
                            _dateController.text = formatter.format(date!);
                          },
                          onSaved: (value) {
                            _dateController.text = value!.trim();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  const TextSpan(text: 'I accept '),
                                  TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(
                                        color: Colors.orange[800],
                                        fontSize: 15,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //TODO: implement terms and condition screen
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
                                  submit(context);
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
                              child: const Text(
                                'CREATE ACCOUNT',
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 105, 0, 0),
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
                                      const TextSpan(
                                        text: 'Already have an account? ',
                                      ),
                                      TextSpan(
                                          text: 'SIGN IN',
                                          style: TextStyle(
                                            color: Colors.orange[800],
                                            fontWeight: FontWeight.w500,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (contect) =>
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
  }

  void submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    print(_nameController.text);
    print(_phoneController.text);
    print(_dateController.text);
    print(_emailController.text);
    // const snackBar = SnackBar(
    //   backgroundColor: Colors.teal,
    //   content: Text(
    //     'Success',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //       color: Colors.white,
    //     ),
    //   ),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileInfoScreen(),
      ),
    );
  }
}