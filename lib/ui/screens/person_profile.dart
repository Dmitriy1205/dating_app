import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app/ui/bloc/personal_profile_cubit/personal_profile_cubit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/models/profile_info_data.dart';

class PersonalProf extends StatelessWidget {
  final String id;
  final String name;
  final String bio;
  final String height;

  // final String image;
  final String joinDate;

  // final List<String> pic;
  final Map<String, dynamic> interests;
  final Map<String, dynamic> lookingFor;

  const PersonalProf({
    Key? key,
    required this.name,
    required this.bio,
    required this.height,
    // required this.image,
    required this.joinDate,
    // required this.pic,
    required this.interests,
    required this.lookingFor,
    required this.id,
    // required this.id,
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
      ),
    );
  }
}

class PersonProfile extends StatefulWidget {
  final String id;
  final String name;
  final String bio;
  final String height;

  // final String image;
  final String joinDate;

  // final List<String> pic;
  final Map<String, dynamic> interests;
  final Map<String, dynamic> lookingFor;

  const PersonProfile({
    Key? key,
    required this.name,
    required this.bio,
    required this.height,
    required this.interests,
    required this.lookingFor,
    // required this.image,
    required this.joinDate,
    // required this.pic,
    required this.id,
  }) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  double _currentPosition = 0.0;

  @override
  void initState() {
    context.read<PersonalProfileCubit>().getPics(widget.id);
    print('current id ${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: state.pic!.length == 0
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
                                    double _validPosition(double position) {
                                      if (position >= state.pic!.length)
                                        return 0;
                                      if (position < 0) {
                                        return state.pic!.length - 1.0;
                                      }
                                      return position;
                                    }

                                    _updatePosition(double position) {
                                      setState(() => _currentPosition =
                                          _validPosition(position));
                                    }

                                    _updatePosition(item!);
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
                              dotsCount: state.pic!.length <= 0 ? 1 :state.pic!.length,
                              position: _currentPosition,
                              decorator: DotsDecorator(
                                  size: Size(15, 12),
                                  activeSize: Size(15, 12),
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
                      const Text(
                        'Location',
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
                      const Text(
                        'Basic Profile',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Height : ',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.height,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Joined Date : ',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.joinDate,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          widget.interests.length,
                          (index) => widget.interests.values.elementAt(index) ==
                                  false
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Chip(
                                    label: Text(
                                      widget.interests.keys.elementAt(index),
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
                        'Looking For',
                        textAlign: TextAlign.start,
                        style: TextStyle(
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
                                          widget.lookingFor.keys
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
