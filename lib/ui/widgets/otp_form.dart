import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/otp_verification/otp_cubit.dart';

class OtpForm extends StatefulWidget {
  final String verId;
  final String? name;
  final String? phone;
  final String? date;
  final String? email;
  final String? joinDate;
  final Widget page;

  const OtpForm({
    Key? key,
    required this.verId,
    this.name,
    this.phone,
    this.date,
    this.email,
    required this.page,
    this.joinDate,
  }) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  late String code;

  // @override
  // void dispose() {
  //   _numberController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state.status!.isLoaded) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => widget.page));
        }
      },
      builder: (context, state) {
        return Padding(
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
                        fieldHeight: 55,
                        fieldWidth: 40,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.black,
                        selectedColor: Colors.black,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      controller: _numberController,
                      appContext: context,
                      length: 6,
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
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();
                  context.read<OtpCubit>().verify(
                        widget.verId,
                        _numberController.text,
                        widget.name ?? '',
                        widget.phone ?? '',
                        widget.date ?? '',
                        widget.email ?? '',
                        widget.joinDate ?? '',
                      );
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
        );
      },
    );
  }
}
