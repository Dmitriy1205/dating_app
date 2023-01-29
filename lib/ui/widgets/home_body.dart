import 'dart:convert';

import 'package:dating_app/core/service_locator.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:dating_app/ui/screens/video_call_screen.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:dating_app/ui/widgets/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/home/home_cubit.dart';
import '../screens/person_profile.dart';

class HomeBody1 extends StatefulWidget {
  const HomeBody1({Key? key}) : super(key: key);

  @override
  State<HomeBody1> createState() => _HomeBody1State();
}

class _HomeBody1State extends State<HomeBody1> {
  final SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.match == true) {
          ReUsableWidgets.showMatchDialog(
            context,
            userName: state.matchUser!.firstName,
            userId: state.matchUser!.id,
            image: state.matchUser!.profileInfo?.image,
            place: state.matchUser!.profileInfo?.location,
            goToChat: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: sl<MessengerCubit>(),
                    child: MessengerScreen(
                      user: state.matchUser!,
                      currentUserid: state.currentUser!.id,
                      currentUserName: state.currentUser!.firstName,
                      userPicture: state.matchUser!.profileInfo!.image!,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status!.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.noUsersLeft),
                Text(AppLocalizations.of(context)!.tryToChangePreferences),
              ],
            ),
          );
        }
        List<UserModel> users = state.user!;
        print('users ${users.length}');
        return Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwipeableCardsSection(
                onCardSwiped: (dir, index, widget) {
                  switch (dir) {
                    case Direction.left:
                      context.read<HomeCubit>().refuseUser(users[index].id!);
                      print(
                          'onDisliked ${users.first.firstName} ${dir} $index');
                      break;
                    case Direction.right:
                      context.read<HomeCubit>().addUser(users[index].id!);

                      print(
                          'onLiked ${users[index].id!} ${users[index].id} ${dir} $index');
                      break;
                  }
                },
                cardController: _cardController,
                context: context,
                items: List.generate(users.length, (index) {
                  print('image ${users.length}');
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PersonalProf(
                            bio: users[index].profileInfo!.bio ?? '',
                            height: users[index].profileInfo!.height ?? '',
                            name: users[index].profileInfo!.name ?? '',
                            interests:
                                users[index].profileInfo!.interests ?? {},
                            lookingFor:
                                users[index].searchPref!.lookingFor ?? {},
                            joinDate: state.user![index].joinDate ?? '',
                            id: state.user![index].id!,
                            status:
                                state.user![index].profileInfo!.status ?? '',
                          );
                        }));
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      users[index].profileInfo!.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.6),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.55,
                            left: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              children: [
                                IconButton(
                                  iconSize: 70,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    context
                                        .read<HomeCubit>()
                                        .refuseUser(users[index].id!);
                                    _cardController.triggerSwipeLeft();
                                    print('left button');
                                  },
                                  icon: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/close.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    iconSize: 70,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      _cardController.triggerSwipeRight();
                                      print('right button');
                                      context
                                          .read<HomeCubit>()
                                          .addUser(users[index].id!);
                                    },
                                    icon: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Image.asset(
                                            'assets/icons/message.png')))
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.65,
                            child: Column(
                              children: [
                                Text(users[index].profileInfo!.name ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '${users[index].searchPref!.distance.toString()} ${AppLocalizations.of(context)!.miles}'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  child: SizedBox(
                                    width: 280,
                                    child: Text(
                                      users[index].profileInfo!.bio ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      textWidthBasis: TextWidthBasis.longestLine,
                                      style: TextStyle(
                                        fontSize: 14.0,

                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[700],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
