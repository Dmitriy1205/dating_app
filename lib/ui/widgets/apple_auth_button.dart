import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/services/service_locator.dart';
import '../bloc/apple_auth/apple_auth_cubit.dart';

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
      listener: (context, state) {
        if (state.status!.isError) {
          final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              state.status!.errorMessage! == '-' ? AppLocalizations.of(context)!.loginError : state.status!.errorMessage!,
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
        return ElevatedButton(
          onPressed: state.status!.isLoading == true
              ? null
              : () => BlocProvider.of<AppleAuthCubit>(context).login(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf5f5f5),
            disabledBackgroundColor: const Color(0xFFf5f5f5),
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
            children: [
              const FaIcon(FontAwesomeIcons.apple, color: Colors.black),
              const SizedBox(
                width: 30,
              ),
              Text(
                state.status!.isLoading == true
                    ? AppLocalizations.of(context)!.signing
                    : AppLocalizations.of(context)!.signingApple,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
