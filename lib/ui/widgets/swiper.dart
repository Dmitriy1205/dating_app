import 'dart:math';
import 'package:flutter/material.dart';

const List<Alignment> cardsAlign = [
  Alignment(0.0, 1.0),
  Alignment(0.0, 0.8),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List.filled(3, Size(1, 1));

class SwipeableCardsSection extends StatefulWidget {
  final SwipeableCardSectionController? cardController;

  //First 3 widgets
  final List<Widget> items;
  final Function? onCardSwiped;
  final double cardWidthTopMul;
  final double cardWidthMiddleMul;
  final double cardWidthBottomMul;
  final double cardHeightTopMul;
  final double cardHeightMiddleMul;
  final double cardHeightBottomMul;
  final Function? appendItemCallback;

  SwipeableCardsSection({
    Key? key,
    this.cardController,
    required BuildContext context,
    required this.items,
    this.onCardSwiped,
    this.cardWidthTopMul = 0.9,
    this.cardWidthMiddleMul = 0.85,
    this.cardWidthBottomMul = 0.8,
    this.cardHeightTopMul = 0.9,
    this.cardHeightMiddleMul = 0.85,
    this.cardHeightBottomMul = 0.5,
    this.appendItemCallback,
  }) {
    cardsSize[0] = Size(MediaQuery.of(context).size.width * cardWidthTopMul,
        MediaQuery.of(context).size.height * cardHeightTopMul);
    cardsSize[1] = Size(MediaQuery.of(context).size.width * cardWidthMiddleMul,
        MediaQuery.of(context).size.height * cardHeightMiddleMul);
    cardsSize[2] = Size(MediaQuery.of(context).size.width * cardWidthBottomMul,
        MediaQuery.of(context).size.height * cardHeightBottomMul);
  }

  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<SwipeableCardsSection>
    with SingleTickerProviderStateMixin {
  int cardsCounter = 0;
  int index = 0;
  Widget? appendCard;
  bool isVisible = false;
  List<Widget?> cards = [];
  late AnimationController _controller;
  bool enableSwipe = true;

  final Alignment defaultFrontCardAlign = Alignment(0.0, 0.0);
  Alignment frontCardAlign = cardsAlign[2];
  double frontCardRot = 0.0;

  void _triggerSwipe(Direction dir) {
    final swipedCallback = widget.onCardSwiped ?? (_, __, ___) => true;
    bool? shouldAnimate = false;
    if (dir == Direction.left) {
      shouldAnimate = swipedCallback(Direction.left, index, cards[0]);
      frontCardAlign = Alignment(
        -0.001,
        0.0,
      );
      // Transform.rotate(
      //     angle: (pi / 180.0) * frontCardRot,
      //     child: Align(
      //         alignment: _controller.status == AnimationStatus.forward
      //             ? CardsAnimation.frontCardDisappearAlignmentAnim(
      //             _controller, frontCardAlign)
      //             .value
      //             : frontCardAlign,));
    } else if (dir == Direction.right) {
      shouldAnimate = swipedCallback(Direction.right, index, cards[0]);
      frontCardAlign = Alignment(0.001, 0.0);
    }
    shouldAnimate ??= true;

    if (shouldAnimate) {
      print('shouldAnimate');
      animateCards();
    }
  }

  void _enableSwipe(bool isSwipeEnabled) {
    setState(() {
      this.enableSwipe = isSwipeEnabled;
    });
  }

  @override
  void initState() {
    super.initState();

    final cardController = widget.cardController;
    if (cardController != null) {
      cardController.listener = _triggerSwipe;
      // cardController.addItem = _appendItem;
      cardController.enableSwipeListener = _enableSwipe;
    }

    // Init cards
    for (cardsCounter = 0; cardsCounter < widget.items.length; cardsCounter++) {
      cards.add(widget.items[cardsCounter]);
    }

    frontCardAlign = cardsAlign[2];

    // Init the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) changeCardsOrder();
    });
    print('cardsCounter $cardsCounter');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IgnorePointer(
      ignoring: !enableSwipe,
      child: Stack(
        children: <Widget>[
          if (cards.length > 1) middleCard(),
          if (cards.isNotEmpty) frontCard(),

          // Prevent swiping if the cards are animating
          ((_controller.status != AnimationStatus.forward))
              ? SizedBox.expand(
                  child: GestureDetector(
                  // While dragging the first card
                  onPanUpdate: (DragUpdateDetails details) {
                    // Add what the user swiped in the last frame to the alignment of the card
                    setState(() {
                      print(
                          'details.delta.dx ${details.delta.dx}    details.delta.dy ${details.delta.dy}');
                      isVisible = true;
                      frontCardAlign = Alignment(
                          frontCardAlign.x +
                              20 *
                                  details.delta.dx /
                                  MediaQuery.of(context).size.width,
                          frontCardAlign.y +
                              1.5 *
                                  details.delta.dy /
                                  MediaQuery.of(context).size.height);
                      frontCardRot =
                          frontCardAlign.x * 2.5; // * rotation speed;
                    });
                  },
                  // When releasing the first card
                  onPanEnd: (_) {
                    // If the front card was swiped far enough to count as swiped
                    final onCardSwiped =
                        widget.onCardSwiped ?? (_, __, ___) => true;
                    bool? shouldAnimate = false;
                    if (frontCardAlign.x > 3.0) {
                      shouldAnimate =
                          onCardSwiped(Direction.right, index, cards[0]);
                    } else if (frontCardAlign.x < -3.0) {
                      shouldAnimate =
                          onCardSwiped(Direction.left, index, cards[0]);
                    } else {
                      // Return to the initial rotation and alignment
                      isVisible = false;
                      setState(() {
                        frontCardAlign = defaultFrontCardAlign;
                        frontCardRot = 0.0;
                      });
                    }
                    shouldAnimate ??= true;
                    if (shouldAnimate) {
                      animateCards();
                    }
                  },
                ))
              : const Center(child: Text('No new Users yet..')),
        ],
      ),
    ));
  }

  // Widget backCard() {
  //   if (cards[2] != null) {
  //     return Align(
  //       alignment: _controller.status == AnimationStatus.forward
  //           ? CardsAnimation.backCardAlignmentAnim(_controller).value
  //           : cardsAlign[0],
  //       child: SizedBox.fromSize(
  //           size: _controller.status == AnimationStatus.forward
  //               ? CardsAnimation.backCardSizeAnim(_controller).value
  //               : cardsSize[2],
  //           child: cards[2]),
  //     );
  //   } else {
  //     return const SizedBox();
  //   }
  // }

  Widget middleCard() {
    if (cards[1] != null) {
      return Align(
        alignment: _controller.status == AnimationStatus.forward
            ? CardsAnimation.middleCardAlignmentAnim(_controller).value
            : cardsAlign[1],
        child: SizedBox.fromSize(
            size: _controller.status == AnimationStatus.forward
                ? CardsAnimation.middleCardSizeAnim(_controller).value
                : cardsSize[1],
            child: cards[1]),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget frontCard() {
    if (cards[0] != null) {
      double a = frontCardAlign.x > 0
          ? _controller.value * pi / 3
          : -_controller.value * pi / 3;
      return Transform.rotate(
          angle: frontCardRot == 0.0 ? a : (pi / 180.0) * frontCardRot,
          child: Align(
            alignment: _controller.status == AnimationStatus.forward
                ? CardsAnimation.frontCardDisappearAlignmentAnim(
                        _controller, frontCardAlign)
                    .value
                : frontCardAlign,
            child: SizedBox.fromSize(
              size: cardsSize[0],
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox.fromSize(size: cardsSize[0], child: cards[0]!),
                  Visibility(
                    visible: isVisible,
                    child: Positioned(
                      top: 150,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: frontCardAlign.x > 0
                            ? ClipRRect(
                                child: Image.asset(
                                  'assets/icons/green_mess.png',
                                  fit: BoxFit.fill,
                                ),
                              )
                            : ClipRRect(
                                child:
                                    Image.asset('assets/icons/red_close.png'),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return const SizedBox();
    }
  }

  void changeCardsOrder() {
    cards.removeAt(0);
    setState(() {
      // Swap cards (back card becomes the middle card; middle card becomes the front card)
      cards.isNotEmpty ? cards[0] : null;
      // if (index + 2 < cardsCounter) {
      //   print('inside if TRUEE');
      //   cards[1] = cards[index + 2];
      // } else {
      //   cards[1] = null;
      // }
      index++;
      frontCardAlign = defaultFrontCardAlign;
      frontCardRot = 0.0;
      isVisible = false;
      _controller.value = 0.0;
    });
  }

  void animateCards() {
    _controller.stop();
    // _controller.value = (pi / 180.0) * frontCardRot;
    print('animateCards 11');
    _controller.value = 0.0;
    _controller.forward();
  }
}

class CardsAnimation {
  static Animation<Alignment> backCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[0], end: cardsAlign[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Size?> backCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[2], end: cardsSize[1]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.4, 0.7, curve: Curves.easeIn)));
  }

  static Animation<Alignment> middleCardAlignmentAnim(
      AnimationController parent) {
    return AlignmentTween(begin: cardsAlign[1], end: cardsAlign[2]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.5, curve: Curves.easeIn)));
  }

  static Animation<Size?> middleCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[1], end: cardsSize[0]).animate(
        CurvedAnimation(
            parent: parent, curve: Interval(0.2, 0.5, curve: Curves.easeIn)));
  }

  static Animation<Alignment> frontCardDisappearAlignmentAnim(
      AnimationController parent, Alignment beginAlign) {
    if (beginAlign.x == -0.001 ||
        beginAlign.x == 0.001 ||
        beginAlign.x > 3.0 ||
        beginAlign.x < -3.0) {
      return AlignmentTween(
              begin: beginAlign,
              end: Alignment(
                  beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0,
                  0.0) // Has swiped to the left or right?
              )
          .animate(CurvedAnimation(
              parent: parent,
              curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));
    } else {
      return AlignmentTween(
              begin: beginAlign,
              end: Alignment(
                  0.0,
                  beginAlign.y > 0
                      ? beginAlign.y + 30.0
                      : beginAlign.y - 30.0) // Has swiped to the top or bottom?
              )
          .animate(CurvedAnimation(
              parent: parent, curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
    }
  }
}

typedef TriggerListener = void Function(Direction dir);
typedef AppendItem = void Function(Widget item);
typedef EnableSwipe = void Function(bool dir);

class SwipeableCardSectionController {
  late TriggerListener listener;
  late AppendItem addItem;
  late EnableSwipe enableSwipeListener;

  void triggerSwipeLeft() {
    return listener.call(Direction.left);
  }

  void triggerSwipeRight() {
    return listener.call(Direction.right);
  }

  void appendItem(Widget item) {
    return addItem.call(item);
  }

  void enableSwipe(bool isSwipeEnabled) {
    return enableSwipeListener.call(isSwipeEnabled);
  }
}

enum Direction {
  left,
  right,
}
