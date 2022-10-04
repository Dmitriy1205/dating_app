import 'package:dating_app/ui/screens/%C2%A0person_profile.dart';
import 'package:dating_app/ui/screens/messenger.dart';
import 'package:dating_app/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/photo_card.dart';
import '../widgets/swiper.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PhotoCard> _photos = [
    PhotoCard(
        title: 'Michale Barns',
        location: '2 miles',
        description: 'A man with million hearts.'

            '',
        imagePath: 'assets/images/working_out.png',
        cardId: '1'),
    PhotoCard(
        title: 'Tom Farly',
        location: '2 miles',
        description: 'An inspiration to many.',
        imagePath: 'assets/images/hiking.png',
        cardId: '2'),
    PhotoCard(
        title: 'Georg Third',
        location: '2 miles',
        description: 'Wierd Guy.',
        imagePath: 'assets/images/baking.png',
        cardId: '3'),
    PhotoCard(
        title: 'Tom Farly',
        location: '2 miles',
        description: 'An inspiration to many.',
        imagePath: 'assets/images/hiking.png',
        cardId: '4'),
    PhotoCard(
        title: 'Tom Farly',
        location: '2 miles',
        description: 'An inspiration to many.',
        imagePath: 'assets/images/hiking.png',
        cardId: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //TODO: navigation to messenger
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Messenger()));
                  },
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset('assets/icons/messenger.png'),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        //TODO: navigation to profile
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                            'assets/icons/profile.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                        onTap: () {
                          //TODO: navigation to filter_screen
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FilterScreen()));
                        },
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Image.asset('assets/icons/menu.png')))),
                  ),
                ],
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Swiper(
                      photoCards: _photos,
                      whenCardSwiped: _cardSwiped,
                      imageScaleType: BoxFit.cover,
                      imageBackgroundColor: Colors.grey,
                      leftButtonBackgroundColor: Colors.red[100],
                      leftButtonIconColor: Colors.red[600],
                      rightButtonBackgroundColor: Colors.lightGreen[100],
                      rightButtonIconColor: Colors.lightGreen[700],
                      leftButtonAction: _leftButtonClicked,
                      rightButtonAction: _rightButtonClicked,
                      onCardTap: _onCardTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

  void _onCardTap(int _index) {
    print('Card with index $_index is Tapped.');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PersonProfile()));
  }

  void _leftButtonClicked() {
    print('Left button clicked');
  }

  void _rightButtonClicked() {
    print('Right button clicked');
  }
}
