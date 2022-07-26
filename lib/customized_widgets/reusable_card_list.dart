import 'package:bmi_calaulator_app/constants.dart';
import 'package:flutter/material.dart';

class ReusableCardList extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color IconColor;
  final Color iconShadowColor;
  ReusableCardList(
      {required this.icon,
      required this.IconColor,
      required this.label,
      required this.iconShadowColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          this.icon,
          size: 80.0,
          color: this.IconColor,
          shadows: [
            Shadow(
              offset: Offset(2.5, 1.0),
              color: this.iconShadowColor,
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(this.label, style: kMainLabelTextStyle),
      ],
    );
  }
}
