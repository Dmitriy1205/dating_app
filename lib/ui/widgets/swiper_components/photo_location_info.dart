import 'package:flutter/material.dart';

import '../../../data/models/photo_card.dart';

class PhotoLocationInfo extends StatelessWidget {
  const PhotoLocationInfo({
    Key? key,
    required this.photoCard,
  }) : super(key: key);

  final PhotoCard photoCard;

  @override
  Widget build(BuildContext context) {
    return Text(
      photoCard.location,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    );
  }
}
