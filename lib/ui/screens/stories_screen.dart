import 'dart:async';

import 'package:dating_app/data/models/story.dart';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  final List<Stories>? stories;

  const StoriesScreen({Key? key, required this.stories}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  int currentIndex = 0;
  late Timer timer;
  final PageController _pageController = PageController();
  bool isHolding = false;
  double progressValue = 0.0;
  DateTime startTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  final totalDuration = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    const totalDuration = Duration(seconds: 5);
    const updateInterval = Duration(milliseconds: 10);

    timer = Timer.periodic(totalDuration, (Timer timer) {
      if (currentIndex < widget.stories!.length - 1) {
        currentIndex++;
      } else {
        Navigator.pop(context);
      }
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      startTime = DateTime.now();
      currentTime = startTime;
    });

    Timer.periodic(updateInterval, (Timer timer) {
      if (mounted) {
        setState(() {
          currentTime = DateTime.now();
        });
      }
    });
  }

  void goToNextImage() {
    if (currentIndex < widget.stories!.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousImage() {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = widget.stories!.length - 1;
    }
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (TapUpDetails details) {
              final screenWidth = MediaQuery.of(context).size.width;
              final tapPosition = details.globalPosition.dx;

              if (tapPosition < screenWidth / 2) {
                goToPreviousImage();
              } else {
                goToNextImage();
              }
            },
            onLongPressStart: (LongPressStartDetails details) {
              setState(() {
                isHolding = true;
              });
              timer.cancel();
            },
            onLongPressEnd: (LongPressEndDetails details) {
              setState(() {
                isHolding = false;
              });
              startTimer();
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.stories!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reversedIndex = widget.stories!.length - 1 - index;
                final currentItem = widget.stories![reversedIndex];

                return Image.network(
                  currentItem.image!,
                  fit: BoxFit.cover,
                );
              },
              onPageChanged: (i) {
                currentIndex = i;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 60,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  height: 30,
                  width: 30,
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 2,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: SizedBox(
                    height: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Row(
                        children:
                            List.generate(widget.stories!.length, (index) {
                          double progress;
                          if (index == currentIndex) {
                            progress = currentTime
                                    .difference(startTime)
                                    .inMilliseconds /
                                totalDuration.inMilliseconds;
                          } else if (index == currentIndex && isHolding) {
                            progress = currentTime
                                    .difference(startTime)
                                    .inMilliseconds /
                                totalDuration.inMilliseconds;
                          } else if (index > currentIndex) {
                            progress = 0.0; // Remaining stories
                          } else {
                            progress = 1.0;
                          }
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
