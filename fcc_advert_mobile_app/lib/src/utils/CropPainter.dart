import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CropPainter extends CustomPainter {
  final ui.Image image;

  CropPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // Source rect: crop 100x100 from center of image
    final src = Rect.fromLTWH(
      (image.width / 2) - 50,
      (image.height / 2) - 50,
      100,
      100,
    );

    // Destination rect: fill the canvas size
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}