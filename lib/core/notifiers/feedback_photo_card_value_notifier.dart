import 'package:flutter/material.dart';

import '../../ui/widgets/swiper.dart';

// Set of ValueNotifier to update the feedback of Draggable widget.
// Draggable widget does not allow state updates once moved, So we will need to upadte values using ValueNotifier.

class FeedbackPhotoCardValueNotifier {
  ValueNotifier<CardActionDirection> swipeDirectionValueNotifier =
      ValueNotifier<CardActionDirection>(CardActionDirection.cardActionNone);

  updateCardSwipeActionValue({required CardActionDirection value}) {
    swipeDirectionValueNotifier.value = value;
  }
}
