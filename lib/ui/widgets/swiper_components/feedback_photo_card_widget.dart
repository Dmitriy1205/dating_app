import 'dart:ui';

import 'package:dating_app/ui/widgets/swiper_components/photo_description_widget.dart';
import 'package:dating_app/ui/widgets/swiper_components/photo_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/notifiers/feedback_photo_card_value_notifier.dart';
import '../../../data/models/photo_card.dart';
import '../swiper.dart';

class FeedbackPhotoCardWidget extends StatelessWidget {
  final PhotoCard photoCard;
  final double cardHeight;
  final double cardWidth;
  final bool hideCenterButton;
  final bool hideTitleText;
  final bool hideDescriptionText;
  final BoxFit imageScaleType;
  final Color? imageBackgroundColor;
  final FeedbackPhotoCardValueNotifier feedbackPhotoCardValueNotifier;
  final IconData? leftButtonIcon;
  final IconData? centerButtonIcon;
  final IconData? rightButtonIcon;
  final Color? leftButtonIconColor;
  final Color? leftButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final Color? centerButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Color? rightButtonBackgroundColor;

  FeedbackPhotoCardWidget({
    required this.photoCard,
    required this.cardHeight,
    required this.cardWidth,
    required this.hideCenterButton,
    required this.hideTitleText,
    required this.hideDescriptionText,
    required this.imageScaleType,
    required this.imageBackgroundColor,
    required this.feedbackPhotoCardValueNotifier,
    this.leftButtonIcon,
    this.centerButtonIcon,
    this.rightButtonIcon,
    this.leftButtonIconColor,
    this.leftButtonBackgroundColor,
    this.centerButtonIconColor,
    this.centerButtonBackgroundColor,
    this.rightButtonIconColor,
    this.rightButtonBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: cardHeight,
        width: cardWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350] ?? Colors.black,
                blurRadius: 7.0,
                spreadRadius: 3.0,
                offset: Offset(2, 3),
              ),
            ]),
        child: Stack(
          children: [
            Container(
              height: cardHeight / 1.3,
              width: cardWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: imageBackgroundColor,
                image: photoCard.isLocalImage
                    ? DecorationImage(
                        image: AssetImage(
                          photoCard.imagePath,
                        ),
                        fit: imageScaleType,
                      )
                    : DecorationImage(
                        image: NetworkImage(
                          photoCard.imagePath,
                        ),
                        fit: imageScaleType,
                      ),
              ),
              margin: const EdgeInsets.all(0.0),
              child: Stack(
                children: [
                  CardActionSpecifcOverlayWidget(
                    key: UniqueKey(),
                    buttonIconColor: Colors.red[800],
                    buttonIcon: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Image.asset('assets/icons/close.png'),
                    ),
                    // widget.leftButtonIcon ?? Icons.close,
                    isVisible: true,
                  ),
                  CardActionSpecifcOverlayWidget(
                    key: UniqueKey(),
                    buttonIconColor: Colors.lightGreen[700],
                    buttonIcon: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Image.asset('assets/icons/message.png'),
                    ),
                    // widget.rightButtonIcon! ?? Icons.check,
                    isVisible: true,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: cardHeight / 4.5,
                  width: cardWidth,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Visibility(
                        visible: !hideTitleText,
                        child: PhotoTitleWidget(photoCard: photoCard),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Visibility(
                        visible: !hideDescriptionText,
                        child: PhotoDescriptionWidget(photoCard: photoCard),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 120,
              left: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LeftButtonWidget(
                    leftButtonBackgroundColor: leftButtonBackgroundColor,
                    leftButtonIconColor: leftButtonIconColor,
                    leftButtonIcon: leftButtonIcon,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  RightButtonWidget(
                    rightButtonBackgroundColor: rightButtonBackgroundColor,
                    rightButtonIconColor: rightButtonIconColor,
                    rightButtonIcon: rightButtonIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Sub-Widgets
class CardActionSpecifcOverlayWidget extends StatelessWidget {
  const CardActionSpecifcOverlayWidget({
    Key? key,
    required this.buttonIconColor,
    required this.buttonIcon,
    required this.isVisible,
  }) : super(key: key);

  final Color? buttonIconColor;
  final Widget buttonIcon;

  // final IconData buttonIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: Duration(milliseconds: 5000),
      curve: Curves.easeOutBack,
      onEnd: () {},
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.3),
          child: Center(
              child: ClipOval(
            child: Container(
              width: 95,
              height: 95,
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: buttonIcon,
                // Icon(
                //   buttonIcon,
                //   color: buttonIconColor ?? Colors.red[800],
                //   size: 55.0,
                // ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class RightButtonWidget extends StatelessWidget {
  const RightButtonWidget({
    Key? key,
    required this.rightButtonBackgroundColor,
    required this.rightButtonIconColor,
    required this.rightButtonIcon,
  }) : super(key: key);

  final Color? rightButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final IconData? rightButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
        splashColor: Colors.white,
        child: SizedBox(
          width: 75,
          height: 75,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Image.asset('assets/icons/message.png'),
          ),
          // Icon(
          //   rightButtonIcon ?? Icons.check,
          //   color: rightButtonIconColor ?? Colors.lightGreen[700],
          //   size: 50,
          // ),
        ),
        onTap: () {},
      ),
    );
  }
}

class LeftButtonWidget extends StatelessWidget {
  const LeftButtonWidget({
    Key? key,
    required this.leftButtonBackgroundColor,
    required this.leftButtonIconColor,
    required this.leftButtonIcon,
  }) : super(key: key);

  final Color? leftButtonBackgroundColor;
  final Color? leftButtonIconColor;
  final IconData? leftButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[200] ?? Colors.grey,
              width: 6,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50),
        ),
        color: leftButtonBackgroundColor ?? Colors.red[100],
        child: InkWell(
          splashColor: Colors.white,
          child: SizedBox(
              width: 65,
              height: 65,
              child: Icon(
                leftButtonIcon ?? Icons.close,
                color: leftButtonIconColor ?? Colors.red[800],
                size: 50,
              )),
          onTap: () {},
        ),
      ),
    );
  }
}
