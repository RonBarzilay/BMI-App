import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;
  final Function onPress;

  ReusableCard(
      {required this.color,
      required this.width,
      required this.height,
      required this.child,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onPress(),
      child: Container(
        child: this.child,
        width: this.width,
        height: this.height,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: this.color, borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
