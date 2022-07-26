import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  /// =================================
  ///            Properties
  /// =================================
  final IconData icon;
  final Function onPress;
  final Function onLongPressStart;
  final Function onLongPressEnd;
  final Function onTapCancel;

  /// =================================
  ///            Constructor
  /// =================================
  RoundIconButton(
      {required this.icon,
      required this.onLongPressStart,
      required this.onLongPressEnd,
      required this.onPress,
      required this.onTapCancel});

  /// =================================
  /// Here We Actually Build The Widget
  /// =================================
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails v) => onPress(),
      // onTapCancel: () => onTapCancel(),
      onLongPressStart: (LongPressStartDetails details) => onLongPressStart(),
      onLongPressEnd: (LongPressEndDetails details) => onLongPressEnd(),
      // onTapDown: (TapDownDetails details) => onTapDown(),
      child: RawMaterialButton(
        elevation: 6.0,
        shape: const CircleBorder(),
        constraints: const BoxConstraints.tightFor(width: 50.0, height: 50.0),
        fillColor: const Color(0x764C4F5E),
        onPressed: () {},
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
