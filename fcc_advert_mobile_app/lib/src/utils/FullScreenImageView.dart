import 'dart:async';

import 'package:flutter/material.dart';

class CropImagePage extends StatefulWidget {
  final String imageUrl;

  CropImagePage({super.key, required this.imageUrl});

  @override
  _CropImagePageState createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  late Offset _startPosition;
  late Rect _cropArea;
  bool _isCropping = false;

  @override
  void initState() {
    super.initState();
    _cropArea = Rect.fromLTWH(100, 100, 200, 200); // Default crop area
  }

  void _startCropping(Offset position) {
    setState(() {
      _startPosition = position;
      _isCropping = true;
    });
  }

  void _updateCropping(Offset position) {
    setState(() {
      double left = _startPosition.dx;
      double top = _startPosition.dy;
      double width = position.dx - _startPosition.dx;
      double height = position.dy - _startPosition.dy;

      _cropArea = Rect.fromLTWH(left, top, width.abs(), height.abs());
    });
  }

  void _endCropping() {
    setState(() {
      _isCropping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crop Image")),
      body: GestureDetector(
        onPanStart: (details) {
          _startCropping(details.localPosition);
        },
        onPanUpdate: (details) {
          if (_isCropping) {
            _updateCropping(details.localPosition);
          }
        },
        onPanEnd: (_) {
          _endCropping();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FutureBuilder<ImageProvider?>(
                future: _loadImage(widget.imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Icon(Icons.error_outline_rounded);
                  } else {
                    return GestureDetector(

                      child: Image(
                        image: snapshot.data!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                },
              ),
            ),
            CustomPaint(
              painter: CropPainter(_cropArea),
            ),
          ],
        ),
      ),
    );
  }
}


Future<ImageProvider?> _loadImage(String? url) async {
  if (url == null || url.isEmpty) {
    // Invalid URL provided
    throw 'Invalid image URL';
  }

  final networkImage = NetworkImage(url);
  final completer = Completer<ImageProvider>();

  final imageStream = networkImage.resolve(const ImageConfiguration());
  final listener = ImageStreamListener(
        (info, _) => completer.complete(networkImage),
    onError: (error, _) => completer.completeError(error!),
  );

  imageStream.addListener(listener);

  try {
    final image = await completer.future.timeout(const Duration(seconds: 5));
    imageStream.removeListener(listener);
    return image;
  } catch (_) {
    imageStream.removeListener(listener);
    throw 'Image loading failed or timed out';
  }
}

class CropPainter extends CustomPainter {
  final Rect cropArea;
  CropPainter(this.cropArea);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    // Draw the background (dim the rest of the image)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint..color = Colors.black.withOpacity(0.5),
    );

    // Draw the crop area
    paint.color = Colors.transparent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    canvas.drawRect(cropArea, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
