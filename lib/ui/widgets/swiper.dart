import 'package:dating_app/ui/widgets/swiper_components/feedback_photo_card_widget.dart';
import 'package:dating_app/ui/widgets/swiper_components/photo_card_layout_widget.dart';
import 'package:flutter/material.dart';
import '../../core/notifiers/feedback_photo_card_value_notifier.dart';
import '../../data/models/photo_card.dart';

enum CardActionDirection {
  cardRightAction,
  cardLeftAction,
  cardCenterAction,
  cardActionNone
}

const String _stackViewKey = 'photo_card_stack_view';

class Swiper extends StatefulWidget {
  final List<PhotoCard> photoCards;
  final Function? whenCardSwiped;
  final bool showLoading;
  final bool hideCenterButton;
  final bool hideTitleText;
  final bool hideDescriptionText;
  final BoxFit imageScaleType;
  final Color? imageBackgroundColor;
  final IconData? leftButtonIcon;
  final IconData? centerButtonIcon;
  final IconData? rightButtonIcon;
  final Color? leftButtonIconColor;
  final Color? leftButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final Color? centerButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Color? rightButtonBackgroundColor;
  final Function? leftButtonAction;
  final Function? centerButtonAction;
  final Function? rightButtonAction;
  final Function? onCardTap;

  const Swiper({
    required this.photoCards,
    this.whenCardSwiped,
    this.showLoading = true,
    this.imageScaleType = BoxFit.cover,
    this.imageBackgroundColor = Colors.black87,
    this.hideCenterButton = false,
    this.hideTitleText = false,
    this.hideDescriptionText = false,
    this.leftButtonIcon,
    this.centerButtonIcon,
    this.rightButtonIcon,
    this.leftButtonIconColor,
    this.leftButtonBackgroundColor,
    this.centerButtonIconColor,
    this.centerButtonBackgroundColor,
    this.rightButtonIconColor,
    this.rightButtonBackgroundColor,
    this.leftButtonAction,
    this.centerButtonAction,
    this.rightButtonAction,
    this.onCardTap,
  });

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  final double _topPadding = 10.0;
  final double _bottomPadding = 35.0;
  final double _offset = 6.0;
  final double _leftPadding = 15.0;
  final double _rightPadding = 15.0;
  List<PhotoCard> _updatedPhotos = [];
  List<PhotoCard> _reversedPhotos = [];

  //States for photo card layout widget
  bool _isPhotoCardLeftOverlayShown = false;
  bool _isPhotoCardRightOverlayShown = false;
  bool _isPhotoCardCenterOverlayShown = false;

  final FeedbackPhotoCardValueNotifier _feedbackPhotoCardValueNotifier =
      FeedbackPhotoCardValueNotifier();

  @override
  void initState() {
    super.initState();
    _reversedPhotos = widget.photoCards.reversed.toList();
    _updatedPhotos = _reversedPhotos;
  }

  @override
  void didUpdateWidget(covariant Swiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _reversedPhotos = widget.photoCards.reversed.toList();
    setState(() {
      _updatedPhotos = _reversedPhotos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxHeight = constraints.maxHeight;
        final double maxWidth = constraints.maxWidth;
        final int totalPhotos = _updatedPhotos.length;
        final double extraOffset = totalPhotos * _offset;
        final double cardHeight =
            maxHeight - (_topPadding + _bottomPadding + extraOffset);
        final double cardWidth = maxWidth - (_leftPadding + _rightPadding);
        // final center = constraints.smallest.center(Offset.zero);

        return Container(
          padding: EdgeInsets.only(
              left: 15.0,
              bottom: _bottomPadding,
              top: _topPadding,
              right: 15.0),
          child:
              //TODO: Refresh button for finished List(if empty = no mathes for yo today, if not empty = put list)
              (_updatedPhotos.isEmpty && widget.showLoading)
                  ? const Center(
                      child: Text('Hello'),
                    )
                  // ?LoadingDataPhotoCardWidget(
                  //         cardHeight: cardHeight,
                  //         cardWidth: cardWidth,
                  //         hideCenterButton: widget.hideCenterButton,
                  //         isLoading: true)
                  : Stack(
                      key: const Key(_stackViewKey),
                      children: _updatedPhotos.map(
                        (updatedPhoto) {
                          final index = _reversedPhotos.indexWhere((photo) {
                            return photo.cardId.toLowerCase() ==
                                updatedPhoto.cardId.toLowerCase();
                          });

                          final reverseOffset =
                              (_updatedPhotos.length - 1) - index;
                          final topOffsetForCard = _offset * reverseOffset;

                          final updatedCardHeight =
                              cardHeight - (_offset * (index));

                          final tapIndex =
                              (widget.photoCards.length - 1) - index;
                          // final matrix = Matrix4.identity()
                          //   ..translate(center.dx, center.dy)
                          //   ..rotateZ(6.0)
                          //   ..translate(-center.dx, -center.dy);
                          return Positioned(
                            top: topOffsetForCard,
                            child: Draggable(
                              axis: Axis.horizontal,
                              childWhenDragging: Container(),
                              maxSimultaneousDrags: 1,
                              onDragCompleted: () {
                                _hideAllPhotoCardOverlayWidgets();
                              },
                              onDragStarted: () {},
                              onDragEnd: (details) {
                                _hideAllPhotoCardOverlayWidgets();
                                if (details.offset.dx > 150.0) {
                                  _updatedPhotos.removeAt(index);
                                  _likeCard(forIndex: index);
                                } else if (details.offset.dx < -150.0) {
                                  _updatedPhotos.removeAt(index);
                                  _unlikeCard(forIndex: index);
                                }
                              },
                              onDragUpdate: (DragUpdateDetails details) {
                                if (details.delta.dx < -3) {
                                  _feedbackPhotoCardValueNotifier
                                      .updateCardSwipeActionValue(
                                          value: CardActionDirection
                                              .cardLeftAction);
                                } else if (details.delta.dx > 3) {
                                  _feedbackPhotoCardValueNotifier
                                      .updateCardSwipeActionValue(
                                          value: CardActionDirection
                                              .cardRightAction);
                                }
                              },
                              feedback: FeedbackPhotoCardWidget(
                                cardHeight: updatedCardHeight,
                                cardWidth: cardWidth,
                                photoCard: updatedPhoto,
                                leftButtonIcon: widget.leftButtonIcon,
                                rightButtonIcon: widget.rightButtonIcon,
                                centerButtonIcon: widget.centerButtonIcon,
                                hideCenterButton: widget.hideCenterButton,
                                hideTitleText: widget.hideTitleText,
                                hideDescriptionText: widget.hideDescriptionText,
                                imageScaleType: widget.imageScaleType,
                                imageBackgroundColor:
                                    widget.imageBackgroundColor,
                                feedbackPhotoCardValueNotifier:
                                    _feedbackPhotoCardValueNotifier,
                                leftButtonIconColor: widget.leftButtonIconColor,
                                leftButtonBackgroundColor:
                                    widget.leftButtonBackgroundColor,
                                centerButtonBackgroundColor:
                                    widget.centerButtonBackgroundColor,
                                centerButtonIconColor:
                                    widget.centerButtonIconColor,
                                rightButtonBackgroundColor:
                                    widget.rightButtonBackgroundColor,
                                rightButtonIconColor:
                                    widget.rightButtonIconColor,
                              ),
                              child: PhotoCardLayoutWidget(
                                cardHeight: updatedCardHeight,
                                cardWidth: cardWidth,
                                imageScaleType: widget.imageScaleType,
                                imageBackgroundColor:
                                    widget.imageBackgroundColor,
                                hideCenterButton: widget.hideCenterButton,
                                hideTitleText: widget.hideTitleText,
                                hideDescriptionText: widget.hideDescriptionText,
                                photoCard: updatedPhoto,
                                leftButtonIcon: widget.leftButtonIcon,
                                rightButtonIcon: widget.rightButtonIcon,
                                centerButtonIcon: widget.centerButtonIcon,
                                isLeftOverlayShown:
                                    _isPhotoCardLeftOverlayShown,
                                isCenterOverlayShown:
                                    _isPhotoCardCenterOverlayShown,
                                isRightOverlayShown:
                                    _isPhotoCardRightOverlayShown,
                                leftButtonIconColor: widget.leftButtonIconColor,
                                leftButtonBackgroundColor:
                                    widget.leftButtonBackgroundColor,
                                centerButtonBackgroundColor:
                                    widget.centerButtonBackgroundColor,
                                centerButtonIconColor:
                                    widget.centerButtonIconColor,
                                rightButtonBackgroundColor:
                                    widget.rightButtonBackgroundColor,
                                rightButtonIconColor:
                                    widget.rightButtonIconColor,
                                onCardTap: widget.onCardTap,
                                photoIndex: tapIndex,
                                leftButtonAction: () {
                                  setState(() {
                                    _showLeftPhotoCardOverlayWidget();
                                  });
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    _updatedPhotos.removeAt(index);
                                    _unlikeCard(forIndex: index);
                                    _hideAllPhotoCardOverlayWidgets();
                                    if (widget.leftButtonAction != null) {
                                      widget.leftButtonAction!();
                                    }
                                  });
                                },
                                centerButtonAction: () {
                                  setState(() {
                                    _showCenterPhotoCardOverlayWidget();
                                  });
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    _updatedPhotos.removeAt(index);
                                    _favoriteCard(forIndex: index);

                                    _hideAllPhotoCardOverlayWidgets();
                                    if (widget.centerButtonAction != null) {
                                      widget.centerButtonAction!();
                                    }
                                  });
                                },
                                rightButtonAction: () {
                                  setState(() {
                                    _showRightPhotoCardOverlayWidget();
                                  });
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    _updatedPhotos.removeAt(index);
                                    _likeCard(forIndex: index);
                                    _hideAllPhotoCardOverlayWidgets();
                                    if (widget.rightButtonAction != null) {
                                      widget.rightButtonAction!();
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
        );
      },
    );
  }

//Hide show overlay widgets
  void _hideAllPhotoCardOverlayWidgets() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _showLeftPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = true;
  }

  void _showRightPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = true;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _showCenterPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = true;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _unlikeCard({required int forIndex}) {
    setState(() {
      if (widget.whenCardSwiped != null) {
        final _reverseOffset = (widget.photoCards.length - 1) - forIndex;
        widget.whenCardSwiped!(
            CardActionDirection.cardLeftAction, _reverseOffset);
      }
    });
  }

  void _likeCard({required int forIndex}) {
    setState(() {
      if (widget.whenCardSwiped != null) {
        final _reverseOffset = (widget.photoCards.length - 1) - forIndex;
        widget.whenCardSwiped!(
            CardActionDirection.cardRightAction, _reverseOffset);
      }
    });
  }

  void _favoriteCard({required int forIndex}) {
    setState(() {
      if (widget.whenCardSwiped != null) {
        final _reverseOffset = (widget.photoCards.length - 1) - forIndex;
        widget.whenCardSwiped!(
            CardActionDirection.cardCenterAction, _reverseOffset);
      }
    });
  }
}
