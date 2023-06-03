import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/services/service_locator.dart';
import '../bloc/facebook_auth/facebook_auth_cubit.dart';
import '../screens/home_screen.dart';

class FacebookAuthButton extends StatelessWidget {
  const FacebookAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FacebookAuthCubit>(
      create: (context) => sl(),
      child: const _FacebookAuthButton(),
    );
  }
}

class _FacebookAuthButton extends StatelessWidget {
  const _FacebookAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FacebookAuthCubit, FacebookAuthState>(
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
                  context.read<FacebookAuthCubit>().login();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf5f5f5),
            disabledBackgroundColor:const Color(0xFFf5f5f5) ,
            elevation: 0,
            fixedSize: const Size(340, 55),
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.facebookF, color: Colors.blue[800]),
              const SizedBox(
                width: 10,
              ),
              Text(
                state.status!.isLoading == true
                    ? AppLocalizations.of(context)!.signing
                    : AppLocalizations.of(context)!.signingFacebook,
                style: TextStyle(color: Colors.blue[800]),
              ),
            ],
          ),
        );
      },
    );
  }
}
