import 'package:bmi_calaulator_app/constants.dart';
import 'package:bmi_calaulator_app/customized_widgets/reusable_card.dart';
import 'package:bmi_calaulator_app/customized_widgets/up_swipe_animation.dart';
import 'package:flutter/material.dart';

calculateDistanceAndNavigate(start, current, context) {
  double distance = current - start;
  // For Right Swipe Direction
  if (distance > 60) {
    naviBackToInputWin(context);
  }
}

void naviBackToInputWin(context) {
  Navigator.pop(context);
}

class ResultWindow extends StatefulWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  ResultWindow(
      {required this.interpretation,
      required this.bmiResult,
      required this.resultText});

  @override
  State<ResultWindow> createState() => _ResultWindowState();
}

enum BMISTATUS { Overweight, Normal, Underweight }

class _ResultWindowState extends State<ResultWindow> {
  IconData iconByBMI() {
    if (widget.resultText == BMISTATUS.Normal.name) {
      return Icons.check_circle;
    } else if (widget.resultText == BMISTATUS.Underweight.name) {
      return Icons.info_outline;
    } else {
      return Icons.warning_amber;
    }
  }

  Color iconColorByBMI() {
    if (widget.resultText == BMISTATUS.Normal.name) {
      return const Color(0xFF24D876);
    } else if (widget.resultText == BMISTATUS.Underweight.name) {
      return const Color(0xFFD8C924);
    } else {
      return const Color(0xFFBE662C);
    }
  }

  TextStyle textStyleByBMI() {
    if (widget.resultText == BMISTATUS.Normal.name) {
      return kNormalResultTextStyle;
    } else if (widget.resultText == BMISTATUS.Underweight.name) {
      return kUnderweightResultTextStyle;
    } else {
      return kOverweightResultTextStyle;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI CALCULATOR'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Expanded(
            //     child: const Text(
            //   "Your BMI",
            //   style: kMainLabelTextStyle,
            // )),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: ReusableCard(
                    color: kActiveCardColor,
                    width: 200,
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconByBMI(),
                                color: iconColorByBMI(),
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.resultText.toUpperCase(),
                                style: textStyleByBMI(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.bmiResult,
                          style: kBMITextStyle,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        const Divider(
                          color: Color(0xFF208EE7),
                          thickness: 3,
                          indent: 30,
                          endIndent: 30,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(widget.interpretation,
                              style: kBodyTextStyle,
                              textAlign: TextAlign.center),
                        ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        const Expanded(
                          flex: 1,
                          child: UpSwipeAnimation(
                              label: 'Swipe Up To Recalculate'),
                        ),
                      ],
                    ),
                    onPress: () {}),
              ),
            )
          ],
        ));
    // body:
  }
}
