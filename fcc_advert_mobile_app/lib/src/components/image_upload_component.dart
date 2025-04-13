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
    if (frontImage != null && backImage != null && wholeImage != null) {
      widget.onImagesChanged(BoardImages(
        front: frontImage,
        back: backImage,
        whole: wholeImage,
      ));
    }
  }

  Future<void> _pickImage(Function(XFile?) setter) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      setter(image);
      _updateParent();
    });
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
              onTap: () => _pickImage((img) => frontImage = img),
            ),
            _uploadButton(
              label: "Back view",
              image: backImage,
              onTap: () => _pickImage((img) => backImage = img),
            ),
            _uploadButton(
              label: "Whole view",
              image: wholeImage,
              onTap: () => _pickImage((img) => wholeImage = img),
            ),
          ],
        ),
      ],
    );
  }

}

