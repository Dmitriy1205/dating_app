import 'package:dating_app/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  late String code;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Verification',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'We\'ve sent a text message to verify your phone number',
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: PinCodeTextField(
                    validator: (value) {
                      code = value!;
                    },
                    autoFocus: true,
                    showCursor: false,
                    pinTheme: PinTheme(
                      borderWidth: 0.5,
                      fieldHeight: 65,
                      fieldWidth: 65,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.black,
                      selectedColor: Colors.black,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    controller: _numberController,
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      code = value;
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                submit(context);
                //TODO: navigation to HomePage
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
                    'CONTINUE',
                  ),
                ),
              ),
            ),
          ],
        ),
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
