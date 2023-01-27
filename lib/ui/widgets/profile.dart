import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/profile/profile_cubit.dart';
import '../screens/edit_profile_screen.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<String> lookin = [
          AppLocalizations.of(context)!.aMentee,
          AppLocalizations.of(context)!.aFriend,
          AppLocalizations.of(context)!.someoneToChillWith,
          AppLocalizations.of(context)!.aRomanticPartner,
          AppLocalizations.of(context)!.aBusinessPartner,
          AppLocalizations.of(context)!.aMentor,
        ];
        List<String> inter = [
          AppLocalizations.of(context)!.photography,
          AppLocalizations.of(context)!.acting,
          AppLocalizations.of(context)!.film,
          AppLocalizations.of(context)!.finArt,
          AppLocalizations.of(context)!.music,
          AppLocalizations.of(context)!.fashion,
          AppLocalizations.of(context)!.dance,
          AppLocalizations.of(context)!.politics,
        ];
        List<String> hobb = [
          AppLocalizations.of(context)!.workingOut,
          AppLocalizations.of(context)!.reading,
          AppLocalizations.of(context)!.cooking,
          AppLocalizations.of(context)!.biking,
          AppLocalizations.of(context)!.drinking,
          AppLocalizations.of(context)!.shopping,
          AppLocalizations.of(context)!.hiking,
          AppLocalizations.of(context)!.baking,
        ];
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: state.images!.isEmpty
                    ? GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'assets/images/empty.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.images!.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                state.images![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.username,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.firstName ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.birthday,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.birthday ?? '',
                          textAlign: TextAlign.start,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.gender,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.profileInfo!.gender == 'Male'
                              ? AppLocalizations.of(context)!.male
                              : AppLocalizations.of(context)!.female,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.about,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.user!.profileInfo!.bio ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.basicProfile,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.height} : ',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.profileInfo!.height ?? '',
                          textAlign: TextAlign.start,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.relationship} : ',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.profileInfo!.status == 'Married'
                              ? AppLocalizations.of(context)!.married
                              : state.user!.profileInfo!.status == ''
                                  ? ''
                                  : AppLocalizations.of(context)!.single,
                          textAlign: TextAlign.start,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.joinedDate} : ',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.joinDate ?? '',
                          textAlign: TextAlign.start,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.lookingFor} : ',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: List<Widget>.generate(
                                state.user!.searchPref!.lookingFor!.length,
                                (index) {
                              String text = '${lookin[index]}. ';

                              return state.user!.searchPref!.lookingFor!.values
                                          .elementAt(index) ==
                                      false
                                  ? const SizedBox()
                                  : Text(
                                      text,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.location,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.currentLocation} : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.profileInfo!.location! == ''
                              ? AppLocalizations.of(context)!
                                  .locationNotSelected
                              : state.user!.profileInfo!.location!,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.interests,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        state.user!.profileInfo!.interests!.length,
                        (index) => state.user!.profileInfo!.interests!.values
                                    .elementAt(index) ==
                                false
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Chip(
                                  label: Text(
                                    inter[index],
                                    style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                      ).toList(),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.hobbies,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        state.user!.profileInfo!.hobbies!.length,
                        (index) => state.user!.profileInfo!.hobbies!.values
                                    .elementAt(index) ==
                                false
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Chip(
                                  label: Text(
                                    hobb[index],
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                      ).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()))
                          .then((value) => context.read<ProfileCubit>().init());
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
                        child: Text(
                          AppLocalizations.of(context)!.editProfile,
                        ),
                      ),
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
