import 'package:dating_app/ui/widgets/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        List<PhotoCard> card = List.generate(
          state.fields!.length,
          (index) => PhotoCard(
            cardId: index.toString(),
            title: state.fields![index].name ?? '',
            description: state.fields![index].bio ?? '',
            imagePath: state.fields![index].image ?? '',
            location: '${state.lookingFor![index].distance.toString()} miles',
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
                      print('Card with index $index is Tapped.');

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PersonalProf(
                          bio: state.fields![index].bio ?? '',
                          height: state.fields![index].height ?? '',
                          name: state.fields![index].name ?? '',
                          interests: state.fields![index].interests ?? {},
                          lookingFor: state.lookingFor![index].lookingFor ?? {},
                          // image: state.fields![_index].image ?? '',
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
