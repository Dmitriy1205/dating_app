import 'dart:ui';

import 'package:dating_app/ui/widgets/swiper_components/photo_description_widget.dart';
import 'package:dating_app/ui/widgets/swiper_components/photo_location_info.dart';
import 'package:dating_app/ui/widgets/swiper_components/photo_title_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/models/photo_card.dart';

class PhotoCardLayoutWidget extends StatefulWidget {
  final PhotoCard photoCard;
  final double cardHeight;
  final double cardWidth;
  final bool hideCenterButton;
  final bool hideTitleText;
  final bool hideDescriptionText;
  final BoxFit imageScaleType;
  final Color? imageBackgroundColor;
  final bool isLeftOverlayShown;
  final bool isCenterOverlayShown;
  final bool isRightOverlayShown;
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
  final int photoIndex;

  PhotoCardLayoutWidget({
    required this.photoCard,
    required this.cardHeight,
    required this.cardWidth,
    required this.hideCenterButton,
    required this.hideTitleText,
    required this.hideDescriptionText,
    required this.imageScaleType,
    required this.imageBackgroundColor,
    required this.isLeftOverlayShown,
    required this.isCenterOverlayShown,
    required this.isRightOverlayShown,
    required this.photoIndex,
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
    Key? key,
  }) : super(key: key);

  @override
  _PhotoCardLayoutWidgetState createState() => _PhotoCardLayoutWidgetState();
}

class _PhotoCardLayoutWidgetState extends State<PhotoCardLayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onCardTap != null) {
          widget.onCardTap!(widget.photoIndex);
        }
      },
      child: Container(
        height: widget.cardHeight,
        width: widget.cardWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300] ?? Colors.black,
              blurRadius:0.0,
              spreadRadius: 1.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: widget.cardHeight / 1.4,
              width: widget.cardWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: widget.imageBackgroundColor,
                image:DecorationImage(
                        image: NetworkImage(
                          widget.photoCard.imagePath,
                        ),
                        fit: widget.imageScaleType,
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
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Image.asset('assets/icons/red_close.png'),
                    ),
                    // widget.leftButtonIcon ?? Icons.close,
                    isVisible: widget.isLeftOverlayShown,
                  ),
                  CardActionSpecifcOverlayWidget(
                    key: UniqueKey(),
                    buttonIconColor: Colors.lightGreen[700],
                    buttonIcon: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Image.asset('assets/icons/green_mess.png'),
                    ),
                    // widget.rightButtonIcon! ?? Icons.check,
                    isVisible: widget.isRightOverlayShown,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: widget.cardHeight / 3.5,
                  width: widget.cardWidth,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      Visibility(
                        visible: !widget.hideTitleText,
                        child: PhotoTitleWidget(photoCard: widget.photoCard),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      PhotoLocationInfo(photoCard: widget.photoCard),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: PhotoDescriptionWidget(
                              photoCard: widget.photoCard),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height/5.3,
              width: MediaQuery.of(context).size.height/2.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LeftButtonWidget(
                    leftButtonBackgroundColor: widget.leftButtonBackgroundColor,
                    leftButtonIconColor: widget.leftButtonIconColor,
                    leftButtonAction: widget.leftButtonAction,
                    leftButtonIcon: widget.leftButtonIcon,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  RightButtonWidget(
                    rightButtonBackgroundColor:
                        widget.rightButtonBackgroundColor,
                    rightButtonIconColor: widget.rightButtonIconColor,
                    rightButtonAction: widget.rightButtonAction,
                    rightButtonIcon: widget.rightButtonIcon,
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
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
      onEnd: () {},
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Center(
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: 135,
              height: 135,
              // color: Colors.white.withOpacity(0.7),
              child: Center(child: buttonIcon

                  // Icon(
                  //   buttonIcon,
                  //   color: buttonIconColor,
                  //   size: 55.0,
                  // ),
                  ),
            ),
          ),
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
    required this.rightButtonAction,
    required this.rightButtonIcon,
  }) : super(key: key);

  final Color? rightButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Function? rightButtonAction;
  final IconData? rightButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
        splashColor: Colors.white,
        child: SizedBox(
          height: 75,
          width: 75,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Image.asset('assets/icons/message.png'),
          ),
        ),
        onTap: () {
          if (rightButtonAction != null) {
            rightButtonAction!();
          }
        },
      ),
    );
  }
}

class LeftButtonWidget extends StatelessWidget {
  const LeftButtonWidget({
    Key? key,
    required this.leftButtonBackgroundColor,
    required this.leftButtonIconColor,
    required this.leftButtonAction,
    required this.leftButtonIcon,
  }) : super(key: key);

  final Color? leftButtonBackgroundColor;
  final Color? leftButtonIconColor;
  final Function? leftButtonAction;
  final IconData? leftButtonIcon;

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
            child: Image.asset('assets/icons/close.png'),
          ),
          // Icon(
          //   leftButtonIcon ?? Icons.close,
          //   color: leftButtonIconColor ?? Colors.red[800],
          //   size: 50,
          // ),
        ),
        onTap: () {
          if (leftButtonAction != null) {
            leftButtonAction!();
          }
        },
      ),
    );
  }
}
