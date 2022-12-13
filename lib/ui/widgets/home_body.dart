import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/ui/widgets/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/models/photo_card.dart';
import '../bloc/home/home_cubit.dart';

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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        List<UserModel> users = state.user!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwipeableCardsSection(key: GlobalKey(),
              cardController: _cardController,
              context: context,
              items: List.generate(users.length, (index) {
                print('image ${users.first.id}');
                return Card(
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
                          height: MediaQuery.of(context).size.height * 0.65),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.6,
                        left: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          children: [
                            IconButton(
                                iconSize: 60,
                                onPressed: () {
                                  print('left button');
                                },
                                icon: Image.asset('assets/icons/close.png')),
                            IconButton(
                                iconSize: 60,
                                onPressed: () {
                                  print('right button');
                                  context
                                      .read<HomeCubit>()
                                      .addUser(users[index].id!);
                                },
                                icon: Image.asset('assets/icons/message.png'))
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.69,
                        child: Column(
                          children: [
                            Text(users[index].profileInfo!.name ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold)),
                            Text(
                                '${users[index].searchPref!.distance.toString()} ${AppLocalizations.of(context)!.miles}'),
                            Text(users[index].profileInfo!.bio ?? '')
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
