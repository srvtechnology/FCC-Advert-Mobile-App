import 'package:fcc_advert_mobile_app/src/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    if (useCamera) {
      final XFile? image = await Navigator.push<XFile?>(
        context,
        MaterialPageRoute(builder: (context) => Camera(onChange: (val) {})),
      );
      if (image != null) {
        setState(() {
          setter(image);
          _updateParent();
        });
      }
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          setter(image);
          _updateParent();
        });
      }
    }
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

}

