import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class PersonProfile extends StatefulWidget {
  const PersonProfile({Key? key}) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  final List<Image> images = [
    Image.asset(
      'assets/images/pic.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/welcome.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/pic.png',
      fit: BoxFit.fill,
    ),
  ];

  double _currentPosition = 0.0;

  double _validPosition(double position) {
    if (position >= images.length) return 0;
    if (position < 0) return images.length - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                        scrollDirection: Axis.vertical,
                        scrollPhysics: const ClampingScrollPhysics(),
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onScrolled: (item) {
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
                    dotsCount: images.length,
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
                children: const [
                  Text(
                    'Name',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Location',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                ],
              ),

            ),
            Divider(color: Colors.grey.shade400,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'About',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
                        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
                        'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                        'nisi ut aliquip ex ea .',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                ],
              ),

            ),
            Divider(color: Colors.grey.shade400,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text(
                    'Basic Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: const [
                      Text(
                        'Height : ',
                        textAlign: TextAlign.start,
                        style: TextStyle( fontSize: 14),
                      ),
                      Text(
                        '164 cm',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: const [
                      Text(
                        'Relationship Status : ',
                        textAlign: TextAlign.start,
                        style: TextStyle( fontSize: 14),
                      ),
                      Text(
                        'single',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: const [
                      Text(
                        'Joined Date : ',
                        textAlign: TextAlign.start,
                        style: TextStyle( fontSize: 14),
                      ),
                      Text(
                        'int cm',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                ],
              ),

            ),
            Divider(color: Colors.grey.shade400,),
            //TODO: down chips
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Interests',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  //TODO: Chips with Interests

                ],
              ),

            ),
            Divider(color: Colors.grey.shade400,),
            //TODO: down chips
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Looking For',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  //TODO: Chips with Interests

                ],
              ),

            ),
            Divider(color: Colors.grey.shade400,),
          ],
        ),
      ),
    );
  }
}
