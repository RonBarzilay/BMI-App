import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmi_calaulator_app/calculator_brain.dart';
import 'package:bmi_calaulator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rainbow_color/rainbow_color.dart';

import '../win/input_win.dart';
import '../win/result_win.dart';

class SideSwipeAnimation extends StatefulWidget {
  /// =================================
  ///            Properties
  /// =================================
  final String label;

  /// =================================
  ///            Constructor
  /// =================================
  const SideSwipeAnimation({required this.label});
  @override
  State<SideSwipeAnimation> createState() => _SideSwipeAnimationState();
}

late AnimationController sideController;

class _SideSwipeAnimationState extends State<SideSwipeAnimation>
    with TickerProviderStateMixin {
  @override
  late Animation colorAnimation;
  Widget build(BuildContext context) {
    @override
        // double for start swipe
        late double xStartSwipe;

    // double for end swipe
    late double xEndSwipe;

    // Minimum distance for navigating page back (pop)
    const int minDistanceForNavi = 15;

    // An AudioPlayer instance to play short sound effect in the app
    final player = AudioPlayer();

    void playNextPageSound() {
      player.setAsset('../assets/resultPageSound.mp3');
      player.setVolume(1);
      player.play();
    }

    void naviToResultWin() {
      playNextPageSound();
      CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
      // Navigator.pushNamed(context, '/YOUR-BMI');
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => ResultWindow(
            bmiResult: calc.calculateBMI(),
            resultText: calc.getResult(),
            interpretation: calc.getInterpretation(),
          ),
          settings: const RouteSettings(name: '/YOUR-BMI'),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }

    void calculateDistanceAndNavigate(double start, double current) {
      double distance = current - start;
      // For Right Swipe Direction
      if (distance > minDistanceForNavi) {
        naviToResultWin();
        sideController.stop();
      }
    }

    void initState() {
      sideController = AnimationController(
          duration: const Duration(seconds: 16), vsync: this);
      colorAnimation =
          RainbowColorTween([Colors.transparent, Colors.grey, Colors.white])
              .animate(sideController);
      sideController.forward();

      sideController.addListener(() {
        if (sideController.isDismissed) {
          Future.delayed(Duration(seconds: 0));
          sideController.forward();
        }
      });
    }

    @override
    dispose() {
      sideController.dispose(); // you need this
    }

    initState();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (details) {
        xStartSwipe = details.globalPosition.dx.floorToDouble();
      },
      onHorizontalDragUpdate: (details) {
        xEndSwipe = details.globalPosition.dx.floorToDouble();
        calculateDistanceAndNavigate(xStartSwipe, xEndSwipe);
      },
      child: Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
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
                  sideController.reset();
                },
              ),
              const SizedBox(width: 10.0),
              AnimatedBuilder(
                animation: sideController,
                builder: (BuildContext context, _) {
                  return Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: colorAnimation.value,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: colorAnimation.value,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: colorAnimation.value,
                      )
                    ],
                  );
                },
              ),
            ]),
      ),
    );
  }
}
