import 'package:dating_app/ui/widgets/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/photo_card.dart';
import '../bloc/home/home_cubit.dart';
import '../screens/person_profile.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        var user = state.user!;
        List<PhotoCard> card = List.generate(
          user.length,
          (index) => PhotoCard(
            cardId: index.toString(),
            title: user[index].profileInfo!.name ?? '',
            description: user[index].profileInfo!.bio ?? '',
            imagePath: user[index].profileInfo!.image ?? '',
            location: '${user[index].searchPref!.distance.toString()} ${AppLocalizations.of(context)!.miles}',
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Swiper(
                    photoCards: card,
                    whenCardSwiped: _cardSwiped,
                    imageScaleType: BoxFit.cover,
                    imageBackgroundColor: Colors.grey,
                    leftButtonBackgroundColor: Colors.red[100],
                    leftButtonIconColor: Colors.red[600],
                    rightButtonBackgroundColor: Colors.lightGreen[100],
                    rightButtonIconColor: Colors.lightGreen[700],
                    leftButtonAction: _leftButtonClicked,
                    rightButtonAction: _rightButtonClicked,
                    onCardTap: (index) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PersonalProf(
                          bio: user[index].profileInfo!.bio ?? '',
                          height: user[index].profileInfo!.height ?? '',
                          name: user[index].profileInfo!.name ?? '',
                          interests: user[index].profileInfo!.interests ?? {},
                          lookingFor: user[index].searchPref!.lookingFor ?? {},
                          joinDate: state.user![index].joinDate ?? '',
                          id: state.user![index].id!,
                        );
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _cardSwiped(CardActionDirection _direction, int _index) {
    print('Swiped Direction ${_direction.toString()} Index $_index');
    //This is just an example to show how one can load more cards.
    //you can skip using this method if you have predefined list of photos array.
    // if (_index == (widget._photos.length - 1)) {
    //   _loadMorePhotos();
    // }
  }

  void _leftButtonClicked() {
    print('Left button clicked');
  }

  void _rightButtonClicked() {
    print('Right button clicked');
  }
}
