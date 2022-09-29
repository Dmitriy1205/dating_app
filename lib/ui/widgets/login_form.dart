import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/screens/sing_up_screen.dart';
import 'package:dating_app/ui/screens/verification_screen.dart';
import 'package:dating_app/ui/widgets/field_decor.dart';
import 'package:dating_app/ui/widgets/google_auth_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../core/functions/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 8, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            Content.login,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
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
                          'Welcome back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
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
                                'SIGN IN',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Don\'t have an account? ',
                                ),
                                TextSpan(
                                    text: 'SIGN UP',
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
                                                    SignUpScreen()));
                                      }),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //TODO: Apple sign in
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.white,
                    elevation: 0,
                    fixedSize: const Size(340, 55),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.apple, color: Colors.black),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'SIGN IN WITH APPLE',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    //TODO: facebook
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.white,
                    elevation: 0,
                    fixedSize: const Size(340, 55),
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.facebookF,
                          color: Colors.blue[800]),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'SIGN IN WITH FACEBOOK',
                        style: TextStyle(color: Colors.blue[800]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const GoogleAuthButton(),
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VerificationScreen()));
  }
}
