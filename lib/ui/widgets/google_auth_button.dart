import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/services/service_locator.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GoogleAuthCubit>(),
      child: const _GoogleAuthButton(),
    );
  }
}

class _GoogleAuthButton extends StatelessWidget {
  const _GoogleAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
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
              : () {
                  context.read<GoogleAuthCubit>().login();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf5f5f5),
            disabledBackgroundColor:const Color(0xFFf5f5f5) ,
            elevation: 0,
            fixedSize: const Size(340, 55),
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.google, color: Colors.red),
              const SizedBox(
                width: 20,
              ),
              Text(
                state.status!.isLoading == true
                    ? AppLocalizations.of(context)!.signing
                    : AppLocalizations.of(context)!.signingGoogle,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
