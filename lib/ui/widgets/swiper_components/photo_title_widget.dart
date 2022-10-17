import 'package:flutter/material.dart';

import '../../../data/models/photo_card.dart';

class PhotoTitleWidget extends StatelessWidget {
  const PhotoTitleWidget({
    Key? key,
    required this.photoCard,
  }) : super(key: key);

  final PhotoCard photoCard;

  @override
  Widget build(BuildContext context) {
    return Text(
      photoCard.title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
