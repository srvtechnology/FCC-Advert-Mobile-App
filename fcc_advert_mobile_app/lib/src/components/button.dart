import 'package:flutter/material.dart';

// Custom button function
Widget customButton({
  required VoidCallback onPressed,
  required String text,
  Widget? child,
  double? width,
  Color backgroundColor = const Color(0xFFF1A2F9), // Default light pink color
  Color textColor = const Color(0xFF494949), // Default text color
  double fontSize = 20, // Default font size
  FontWeight fontWeight = FontWeight.w500, // Default font weight
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)), // Default border radius
}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), // Shadow color with opacity
          spreadRadius: 0.1, // How much the shadow spreads
          blurRadius: 10, // Softness of the shadow
          offset: Offset(0, 4), // Moves the shadow (x, y)
        ),
      ],
    ),
    height: 60,
    width: width??double.infinity,
    child: ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      child: child ?? FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      )
    ),
  );
}
