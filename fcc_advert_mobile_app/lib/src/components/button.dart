import 'package:flutter/material.dart';

// Custom button function
Widget customButton({
  required VoidCallback onPressed,
  required String text,
  Color backgroundColor = const Color(0xFFF1A2F9), // Default light pink color
  Color textColor = const Color(0xFF494949), // Default text color
  double fontSize = 20, // Default font size
  FontWeight fontWeight = FontWeight.w500, // Default font weight
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 100, vertical: 15), // Default padding
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
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    ),
  );
}
