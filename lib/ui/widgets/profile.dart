import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.images!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        const Text(
                          'Username',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.profile!.name!,
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
                        const Text(
                          'Birthday',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.birthDate!,
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
                        const Text(
                          'Gender',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.profile!.gender!,
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
                    const Text(
                      'About',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.profile!.bio!,
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
                    const Text(
                      'Basic Profile',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Height : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.profile!.height!,
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
                      children: const [
                        Text(
                          'Relationship Status : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Single',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Joined Date : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          state.user!.joinDate!,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Looking For : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Flexible(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: List<Widget>.generate(
                              state.lookingFor!.length,
                              (index) =>
                                  state.lookingFor!.values.elementAt(index) ==
                                          false
                                      ? const SizedBox()
                                      : Text(
                                          '${state.lookingFor!.keys.elementAt(index)}, ',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                            ).toList(),
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
                    const Text(
                      'Location',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Current Location : ',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Kyiv, Ukraine',
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
                    const Text(
                      'Interests',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        state.profile!.interests!.length,
                            (index) =>
                        state.profile!.hobbies!.values.elementAt(index) ==
                            false
                            ? const SizedBox()
                            : Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            label: Text(
                              state.profile!.hobbies!.keys
                                  .elementAt(index),
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
                    const Text(
                      'Hobbies',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        state.profile!.interests!.length,
                            (index) =>
                        state.profile!.interests!.values.elementAt(index) ==
                            false
                            ? const SizedBox()
                            : Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Chip(
                            label: Text(
                              state.profile!.interests!.keys
                                  .elementAt(index),
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
                          .then((value) =>
                              context.read<ProfileCubit>().getData());
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
                          'EDIT PROFILE',
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
