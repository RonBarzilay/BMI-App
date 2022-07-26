import 'dart:async';

import 'package:bmi_calaulator_app/constants.dart';
import 'package:bmi_calaulator_app/customized_widgets/reusable_card.dart';
import 'package:bmi_calaulator_app/customized_widgets/reusable_card_list.dart';
import 'package:bmi_calaulator_app/customized_widgets/reusable_round_icon_button.dart';
import 'package:bmi_calaulator_app/customized_widgets/side_swipe_animation.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constants.dart';

/// =================================
///            Variables
/// =================================
// enum for Gender
enum Gender { MALE, FEMALE }

// Enum for gender
late Enum gender = Gender.MALE;

// int for height
int height = 180;

// int for weight
int weight = 75;

// int for age
int age = 20;

// const int for MAX age
const int maxAge = 120;

// The time between each inc/dec age on long press
Timer timer = Timer.periodic(const Duration(milliseconds: 100), (t) {});

// The vibrate duration for each button press (in milliseconds)
int vibrateDuration = 5;

// The short vibrate duration for each button press (in milliseconds)
int shortVibrateDuration = 0;

class InputWindow extends StatefulWidget {
  @override
  _InputWindowState createState() => _InputWindowState();
}

class _InputWindowState extends State<InputWindow> {
  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;

  void startShortVibration() {
    try {
      HapticFeedback.heavyImpact();
    } on Exception catch (exception) {
      print(
          "This Device Has No Support For Vibration"); // only executed if error is of type Exception
    } catch (error) {
      print("error");
      // executed for errors of all types other than Exception
    }
  }

  void startVeryShortVibration() {
    try {
      HapticFeedback.lightImpact();
    } on Exception catch (exception) {
      print(
          "This Device Has No Support For Vibration"); // only executed if error is of type Exception
    } catch (error) {
      print("error");
      // executed for errors of all types other than Exception
    }
  }

  void updateColor(Gender genderEnum) {
    genderEnum == Gender.MALE
        ? setState(() {
            maleCardColor = kActiveCardColor;
            femaleCardColor = kInactiveCardColor;
          })
        : setState(() {
            femaleCardColor = kActiveCardColor;
            maleCardColor = kInactiveCardColor;
          });

    // if (genderEnum == Gender.MALE) {
    //
    // }
  }

  void decrementAge() {
    if (age > 1) {
      startVeryShortVibration();
      setState(() {
        age--;
      });
    }
  }

  void incrementAge() {
    if (age < 120) {
      startVeryShortVibration();
      setState(() {
        age++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text('About BMI App'),
                        content: Text(
                            '\n BMI - Body Mass Index \n\n It is a measure that uses your height and weight to work out if your weight is healthy \n\n Developed By \n Ron Barzilay'),
                        actions: [
                          CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                              child: Text('Got it, Thanks')),
                          // CupertinoDialogAction(child: Text('Got it, Thanks')),
                        ],
                      );
                    });
              },
              child: Icon(
                Icons.info_outline,
                size: 27,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ReusableCard(
                    width: 170.0,
                    height: 200.0,
                    color: maleCardColor,
                    onPress: () {
                      updateColor(Gender.MALE);
                      startShortVibration();
                      gender = Gender.MALE;
                    },
                    child: ReusableCardList(
                      IconColor: kMarsIconColor,
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                      iconShadowColor: kBottomBarColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ReusableCard(
                    onPress: () {
                      updateColor(Gender.FEMALE);
                      startShortVibration();
                      gender = Gender.FEMALE;
                    },
                    width: 170.0,
                    height: 200.0,
                    color: femaleCardColor,
                    child: ReusableCardList(
                      IconColor: kBottomBarColor,
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                      iconShadowColor: kMarsIconColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: ReusableCard(
                onPress: () {},
                width: 360.0,
                height: 200.0,
                color: kActiveCardColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'HEIGHT',
                        style: kMainLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            height.toString(),
                            style: kNumberTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            'cm',
                            style: kMainLabelTextStyle,
                          )
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        // Slider for HEIGHT
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(),
                          child: Slider(
                              // Default start value
                              value: height.toDouble(),
                              min: 130,
                              max: 230,
                              // (double status) is required for current Slider value
                              onChangeStart: (double status) {
                                startShortVibration();
                              },
                              onChanged: (double status) {
                                setState(() {
                                  height = status.toInt();
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  // ReusableCard for WEIGHT
                  child: ReusableCard(
                    onPress: () {},
                    width: 170.0,
                    height: 200.0,
                    color: kActiveCardColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          const Text(
                            'WEIGHT',
                            style: kMainLabelTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: SleekCircularSlider(
                              initialValue: 70.0,
                              onChange: (double status) {
                                setState(() {
                                  weight = status.toInt();
                                });
                              },
                              onChangeStart: (double status) {
                                startShortVibration();
                              },
                              min: 40,
                              max: 150,
                              appearance: CircularSliderAppearance(
                                  customWidths: CustomSliderWidths(
                                      progressBarWidth: 12, trackWidth: 5),
                                  animationEnabled: true,
                                  animDurationMultiplier: 5,
                                  angleRange: 200,
                                  startAngle: 45,
                                  infoProperties: InfoProperties(
                                      modifier: (double status) {
                                        weight = status.toInt();
                                        return status.toInt().toString();
                                      },
                                      mainLabelStyle: kNumberTextStyle,
                                      bottomLabelText: "kg",
                                      bottomLabelStyle: kMainLabelTextStyle),
                                  customColors:
                                      CustomSliderColors(progressBarColors: [
                                    Color(0x8E208EE7),
                                    Colors.green,
                                    kBottomBarColor,
                                  ], trackColor: Color(0x45208EE7))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ReusableCard(
                      onPress: () {},
                      width: 170.0,
                      height: 200.0,
                      color: kActiveCardColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'AGE',
                              style: kMainLabelTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 25),
                              child: CupertinoProgressBar(
                                value: age / maxAge,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 50,
                            // ),
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: Icons.remove,
                                  onPress: () {
                                    startVeryShortVibration();
                                    decrementAge();
                                  },
                                  onLongPressStart: () {
                                    startVeryShortVibration();
                                    timer = Timer.periodic(
                                        const Duration(milliseconds: 160), (t) {
                                      decrementAge();
                                    });
                                  },
                                  onLongPressEnd: () {
                                    timer.cancel();
                                  },
                                  onTapCancel: () {
                                    timer.cancel();
                                  },
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                RoundIconButton(
                                  icon: Icons.add,
                                  onPress: () {
                                    startVeryShortVibration();
                                    incrementAge();
                                  },
                                  onLongPressStart: () {
                                    startVeryShortVibration();
                                    timer = Timer.periodic(
                                        const Duration(milliseconds: 160), (t) {
                                      incrementAge();
                                    });
                                  },
                                  onLongPressEnd: () {
                                    timer.cancel();
                                  },
                                  onTapCancel: () {
                                    timer.cancel();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            const Expanded(
              flex: 2,
              child: SideSwipeAnimation(label: 'Swipe To Calculate'),
            ),
          ],
        ),
      ),
      // floatingActionButton: Theme(
      //   data: ThemeData.light(),
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     child: Icon(Icons.add),
      //   ),
      // ),
    );
  }
}
