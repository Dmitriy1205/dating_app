import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/service_locator.dart';
import '../bloc/apple_auth/apple_auth_cubit.dart';
import '../screens/home_screen.dart';

class AppleAuthButton extends StatelessWidget {
  const AppleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) return Container();
    return BlocProvider<AppleAuthCubit>(
      create: (context) => sl(),
      child: const _AppleAuthButton(),
    );
  }
}

class _AppleAuthButton extends StatelessWidget {
  const _AppleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppleAuthCubit, AppleAuthState>(
      listener: ((context, state) {
        if (state.status!.isLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      }),
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status!.isLoading == true
              ? null
              : () => BlocProvider.of<AppleAuthCubit>(context).login(),
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
        );
      },
    );
  }
}
