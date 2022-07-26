import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmi_calaulator_app/constants.dart';
import 'package:bmi_calaulator_app/customized_widgets/side_swipe_animation.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class UpSwipeAnimation extends StatefulWidget {
  /// =================================
  ///            Properties
  /// =================================
  final String label;

  /// =================================
  ///            Constructor
  /// =================================
  const UpSwipeAnimation({required this.label});
  @override
  State<UpSwipeAnimation> createState() => _UpSwipeAnimationState();
}

class _UpSwipeAnimationState extends State<UpSwipeAnimation>
    with TickerProviderStateMixin {
  @override
  late AnimationController upController;
  late Animation colorAnimation;
  Widget build(BuildContext context) {
    // double for start down swipe y
    late double yStartSwipe;

    // double for end down swipe y
    late double yEndSwipe;

    // Minimum distance for navigating page back (pop)
    const int minDistanceForNavi = -15;

    void naviBackToInputWin(context) {
      Navigator.pop(context);
      sideController.forward();
    }

    calculateDistanceAndNavigate(start, current, context) {
      double distance = current - start;
      // For Right Swipe Direction
      if (distance < minDistanceForNavi) {
        naviBackToInputWin(context);
        upController.stop(canceled: false);
      }
    }

    @override
    void initState() {
      upController = AnimationController(
          duration: const Duration(seconds: 16), vsync: this);
      colorAnimation =
          RainbowColorTween([Colors.transparent, Colors.grey, Colors.white])
              .animate(upController);
      upController.forward();

      upController.addListener(() {
        if (upController.isDismissed) {
          Future.delayed(Duration(seconds: 0));
          upController.forward();
        }
      });
    }

    @override
    dispose() {
      upController.dispose(); // you need this
    }

    initState();

    return GestureDetector(
      onVerticalDragStart: (details) {
        yStartSwipe = details.globalPosition.dy.floorToDouble();
      },
      onVerticalDragUpdate: (details) {
        yEndSwipe = details.globalPosition.dy.floorToDouble();
        calculateDistanceAndNavigate(yStartSwipe, yEndSwipe, context);
      },
      child: AnimatedBuilder(
        animation: upController,
        builder: (BuildContext context, _) {
          return Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                size: 50,
                color: colorAnimation.value,
              ),
              Icon(
                Icons.keyboard_arrow_up,
                size: 50,
                color: colorAnimation.value,
              ),
              Icon(
                Icons.keyboard_arrow_up,
                size: 50,
                color: colorAnimation.value,
              ),
              Expanded(
                flex: 2,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      widget.label,
                      speed: const Duration(milliseconds: 1000),
                      textStyle: kSwipeableButtonTextStyle,
                      colors: [Colors.white, Colors.grey, Colors.white10],
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  onNext: (int a, bool aa) {
                    upController.reset();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
