import 'package:flutter/material.dart';

import '../../../data/models/photo_card.dart';

class PhotoDescriptionWidget extends StatelessWidget {
  const PhotoDescriptionWidget({
    Key? key,
    required this.photoCard,
  }) : super(key: key);

  final PhotoCard photoCard;

  @override
  Widget build(BuildContext context) {
    return Text(
      photoCard.description,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    );
  }
}
