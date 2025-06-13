import 'package:fcc_advert_mobile_app/src/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../CameratoolPage.dart';

class BoardImages {
  final XFile? front;
  final XFile? back;
  final XFile? whole;

  BoardImages({this.front, this.back, this.whole});
}

class AdvertisementBoardImages extends StatefulWidget {
  final void Function(BoardImages) onImagesChanged;

  const AdvertisementBoardImages({
    super.key,
    required this.onImagesChanged,
  });

  @override
  State<AdvertisementBoardImages> createState() => _AdvertisementBoardImagesState();
}

class _AdvertisementBoardImagesState extends State<AdvertisementBoardImages> {
  final ImagePicker _picker = ImagePicker();
  XFile? frontImage;
  XFile? backImage;
  XFile? wholeImage;
  int state = 0;

  void _updateParent() {
    widget.onImagesChanged(BoardImages(
      front: frontImage,
      back: backImage,
      whole: wholeImage,
    ));
  }

  Future<void> _pickImage(Function(XFile?) setter, {bool useCamera = false}) async {
    XFile? image;

    if (useCamera) {
      image = await Navigator.push<XFile?>(
        context,
        MaterialPageRoute(builder: (context) => Camera(onChange: (val) {})),
      );
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      bool? confirmed = await _showImagePreviewDialog(image);
      if (confirmed == true) {
        setState(() {
          setter(image);
          _updateParent();
        });
      }
    }
  }

  Future<bool?> _showImagePreviewDialog(XFile image) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              SizedBox.expand(
                child: InteractiveViewer(
                  panEnabled: true, // Allow panning
                  boundaryMargin: EdgeInsets.all(50), // Allows image to move within a margin
                  minScale: 0.1, // Minimum zoom level (zoom out)
                  maxScale: 4.0, // Maximum zoom level (zoom in)
                  child: Image.file(
                    File(image.path),
                    fit: BoxFit.contain, // or BoxFit.cover depending on your UI preference
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageSourceSelector(Function(XFile?) setter) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(setter, useCamera: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(setter, useCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _uploadButton({
    required String label,
    required XFile? image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          image == null
              ? const Icon(Icons.upload, size: 40)
              : ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(image.path),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Advertisement board images",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _uploadButton(
              label: "Front view",
              image: frontImage,
              onTap: () => _showImageSourceSelector((img) => frontImage = img),
            ),
            _uploadButton(
              label: "Back view",
              image: backImage,
              onTap: () => _showImageSourceSelector((img) => backImage = img),
            ),
            _uploadButton(
              label: "Whole view",
              image: wholeImage,
              onTap: () => _showImageSourceSelector((img) => wholeImage = img),
            ),
          ],
        ),
      ],
    );
  }

  void _openCameraTool() async {
    final Uri url = Uri.parse('https://fccadmin.org/server/api/camera-tool');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication); // opens in browser
    } else {
      throw 'Could not launch $url';
    }
  }
}

