import 'package:dating_app/ui/bloc/otp_verification/otp_cubit.dart';
import 'package:dating_app/ui/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String? verId;
  final int pageId;
  final String? name;
  final String? phone;
  final String? date;
  final String? email;
  final String? joinDate;
  final Widget page;
  final String? language;

  const OtpVerificationScreen({
    Key? key,
    this.verId,
    this.name,
    this.phone,
    this.date,
    this.email,
    required this.page,
    this.joinDate,
    required this.pageId,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OtpCubit>(),
      child: Scaffold(
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
        body: OtpForm(
          page: page,
          verId: verId!,
          name: name,
          phone: phone,
          date: date,
          joinDate: joinDate,
          email: email,
          pageId: pageId,
          language: language,
        ),
      ),
    );
  }
}
