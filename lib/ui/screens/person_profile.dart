import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app/ui/bloc/personal_profile_cubit/personal_profile_cubit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/service_locator.dart';

class PersonalProf extends StatelessWidget {
  final String id;
  final String name;
  final String bio;
  final String height;
  final String joinDate;
  final Map<String, dynamic> interests;
  final Map<String, dynamic> lookingFor;
  final String status;
  final String location;

  const PersonalProf({
    Key? key,
    required this.name,
    required this.bio,
    required this.height,
    required this.joinDate,
    required this.interests,
    required this.lookingFor,
    required this.id,
    required this.status,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonalProfileCubit>(),
      child: PersonProfile(
        name: name,
        bio: bio,
        height: height,
        interests: interests,
        lookingFor: lookingFor,
        joinDate: joinDate,
        id: id,
        status: status,
        location: location,
      ),
    );
  }
}

class PersonProfile extends StatefulWidget {
  final String id;
  final String name;
  final String bio;
  final String height;
  final String joinDate;
  final Map<String, dynamic> interests;
  final Map<String, dynamic> lookingFor;
  final String status;
  final String location;

  const PersonProfile({
    Key? key,
    required this.name,
    required this.bio,
    required this.height,
    required this.interests,
    required this.lookingFor,
    required this.joinDate,
    required this.id,
    required this.status,
    required this.location,
  }) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  double _currentPosition = 0.0;

  @override
  void initState() {
    context.read<PersonalProfileCubit>().getPics(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
          builder: (context, state) {
            if (state.status!.isLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 400),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final List<Image> pic = List.generate(
              state.pic!.length,
              (index) => Image.network(
                state.pic![index],
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 1.7,
                filterQuality: FilterQuality.high,
              ),
            );
            List<String> lookin = [
              AppLocalizations.of(context)!.aMentee,
              AppLocalizations.of(context)!.aFriend,
              AppLocalizations.of(context)!.someoneToChillWith,
              AppLocalizations.of(context)!.aRomanticPartner,
              AppLocalizations.of(context)!.aBusinessPartner,
              AppLocalizations.of(context)!.aMentor,
            ];
            List<String> inter = [

              AppLocalizations.of(context)!.acting,
              AppLocalizations.of(context)!.dance,
              AppLocalizations.of(context)!.fashion,
              AppLocalizations.of(context)!.film,
              AppLocalizations.of(context)!.finArt,
              AppLocalizations.of(context)!.music,
              AppLocalizations.of(context)!.photography,
              AppLocalizations.of(context)!.politics,
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: state.pic!.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'assets/images/empty.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : CarouselSlider(
                              items: pic,
                              options: CarouselOptions(
                                  scrollDirection: Axis.vertical,
                                  scrollPhysics: const ClampingScrollPhysics(),
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  onScrolled: (item) {
                                    double validPosition(double position) {
                                      if (position >= state.pic!.length) {
                                        return 0;
                                      }
                                      if (position < 0) {
                                        return state.pic!.length - 1.0;
                                      }
                                      return position;
                                    }

                                    updatePosition(double position) {
                                      setState(() => _currentPosition =
                                          validPosition(position));
                                    }

                                    updatePosition(item!);
                                  }),
                            ),
                      // Image.asset('assets/images/pic.png',fit: BoxFit.fill,),
                    ),
                    Positioned(
                      child: IconButton(
                        padding: const EdgeInsets.fromLTRB(23, 70, 8, 8),
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
                    Positioned(
                      right: 20,
                      top: 70,
                      child: DotsIndicator(
                        axis: Axis.vertical,
                        dotsCount: state.pic!.isEmpty ? 1 : state.pic!.length,
                        position: _currentPosition,
                        decorator: DotsDecorator(
                            size: const Size(15, 12),
                            activeSize: const Size(15, 12),
                            color: Colors.pink.withOpacity(0.2),
                            activeColor: Colors.pink.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.location == ''
                            ? 'Unknown location'
                            : widget.location,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
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
                        widget.bio,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.height} : ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.height,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.relationship} : ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.status == 'Married'
                                ? AppLocalizations.of(context)!.married
                                : widget.status == ''
                                    ? ''
                                    : AppLocalizations.of(context)!.single,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.joinedDate} : ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.joinDate,
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                        height: 15,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          widget.interests.length,
                          (index) =>
                              widget.interests.values.elementAt(index) == false
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
                        AppLocalizations.of(context)!.lookingFor,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          widget.lookingFor.length,
                          (index) =>
                              widget.lookingFor.values.elementAt(index) == false
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Chip(
                                        label: Text(
                                          lookin[index],
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
