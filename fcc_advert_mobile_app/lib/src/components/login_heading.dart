import 'package:fcc_advert_mobile_app/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
// Custom header component function
Widget customHeader({
  required String title,
  required String resolutionText,
  String? logoAssetPath = 'assets/heading_image.png', // Default logo asset path
  double titleFontSize = 24, // Default font size for title
  FontWeight titleFontWeight = FontWeight.w500, // Default font weight for title
  Color titleColor = const Color(0xFFF736D6D), // Default title color
  double resolutionFontSize = 20, // Default font size for resolution text
  FontWeight resolutionFontWeight = FontWeight.w500, // Default font weight for resolution text
  Color resolutionColor = const Color(0xFFF796666), // Default resolution text color
  double logoHeight = 170, // Default logo height
  double logoWidth = 170, // Default logo width
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
                color: titleColor,
              ),
            ),
          ),
        ),
        // Logo
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            child: Center(
              child: SizedBox(
                height: logoHeight,
                width: logoWidth,
                child: FittedBox(
                  fit: BoxFit.contain, // Ensures image fits inside the box
                  child: Image.asset(
                    logoAssetPath!,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: 50); // Fallback if image fails to load
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        // Resolution Text
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Text(
              resolutionText,
              style: TextStyle(
                fontSize: resolutionFontSize,
                color: resolutionColor,
                fontWeight: resolutionFontWeight,
                fontFamily: REGULAR
              ),
            ),
          ),
        ),

      ],
    ),
  );
}