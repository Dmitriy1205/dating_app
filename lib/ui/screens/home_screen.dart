import 'package:flutter/material.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/photo_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PhotoCard> _photos = [
    PhotoCard(
        title: 'Sonu Sood',
        description: 'A man with million hearts.',
        imagePath: 'assets/images/working_out.png',
        cardId: '1'),
    PhotoCard(
        title: 'Dr APJ Abdul Kalam',
        description: 'An inspiration to many.',
        imagePath: 'assets/images/hiking.png',
        cardId: '2'),
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
                    },
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Image.asset('assets/icons/messenger.png')))),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        //TODO: navigation to profile
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
                          //TODO: navigation to settings
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
                child: Stack(children: [
                  PhotoCardSwiper(
                    photos: _photos,
                    cardSwiped: _cardSwiped,
                    showLoading: true,
                    hideCenterButton: true,
                    hideTitleText: false,
                    hideDescriptionText: false,
                    imageScaleType: BoxFit.cover,
                    imageBackgroundColor: Colors.grey,
                    leftButtonIcon: IconData(1),
                    rightButtonIcon: Icons.check,
                    leftButtonBackgroundColor: Colors.red[100],
                    leftButtonIconColor: Colors.red[600],
                    rightButtonBackgroundColor: Colors.lightGreen[100],
                    rightButtonIconColor: Colors.lightGreen[700],
                    leftButtonAction: _leftButtonClicked,
                    rightButtonAction: _rightButtonClicked,
                    onCardTap: _onCardTap,
                  ),
                ]),
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
    //Here you can navigate to detail screen or so.
  }

  void _leftButtonClicked() {
    print('Left button clicked');
  }


  void _rightButtonClicked() {
    print('Right button clicked');
  }
}
