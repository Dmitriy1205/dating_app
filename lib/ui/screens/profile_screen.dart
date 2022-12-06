import 'package:dating_app/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/service_locator.dart';
import '../bloc/profile/profile_cubit.dart';
import '../widgets/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 15, 8, 8),
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
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.profile,
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  //TODO: navigation to settings
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image.asset('assets/icons/settings.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<ProfileCubit>(),
        child: const Profile(),
      ),
    );
  }
}
