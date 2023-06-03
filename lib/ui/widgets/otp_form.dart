import 'package:dating_app/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/otp_verification/otp_cubit.dart';
import '../bloc/sign_in/sign_in_cubit.dart';
import '../bloc/sign_up/sign_up_cubit.dart';

class OtpForm extends StatefulWidget {
  final String verId;
  final int pageId;
  final String? name;
  final String? language;
  final String? phone;
  final String? date;
  final String? email;
  final String? joinDate;
  final Widget page;

  const OtpForm({
    Key? key,
    required this.verId,
    this.name,
    this.language,
    this.phone,
    this.date,
    this.email,
    required this.page,
    this.joinDate,
    required this.pageId,
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
          context.read<SignUpCubit>().reset();
          context.read<SignInCubit>().reset();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => widget.page));
        }
      },
      builder: (context, state) {
        if (state.status!.isLoading){
          return const LoadingIndicator();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.verification,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.weveSentaText,
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
                          return null;
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
                    if (widget.pageId == 1) {
                      context.read<OtpCubit>().verifySignUp(
                            verId: widget.verId,
                            date: widget.date ?? '',
                            code: _numberController.text,
                            name: widget.name ?? '',
                            phone: widget.phone ?? '',
                            email: widget.email ?? '',
                            joinDate: widget.joinDate ?? '',
                            language: widget.language ?? '',
                          );
                    } else {
                      context.read<OtpCubit>().verifyLogin(
                            widget.verId,
                            code,
                          );
                    }
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
                      width: 340,
                      height: 55,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.continueButton,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
