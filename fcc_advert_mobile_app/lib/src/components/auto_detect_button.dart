import 'package:flutter/material.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';

import '../CameratoolPage.dart';

class AdvertisementAreaInput extends StatefulWidget {
  final VoidCallback onAutoDetect;
  final void Function(String,String,String)? onChange;
  final String? value;

  const AdvertisementAreaInput({
    super.key,
    this.onChange,
    this.value,
    required this.onAutoDetect,
  });

  @override
  State<AdvertisementAreaInput> createState() => _AdvertisementAreaInputState();
}

class _AdvertisementAreaInputState extends State<AdvertisementAreaInput> {
  late TextEditingController _controller;
  double? width, height;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? "");
  }

  @override
  void didUpdateWidget(covariant AdvertisementAreaInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? "";
      print(widget.value);
      widget.onChange!(widget.value ?? "","","");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advertisement area',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.5,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  /*if(widget.onChange != null){
                    widget.onChange!(value);
                  }*/
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: "Enter Area",
                  hintStyle: TextStyle(color: AppColors.placeholderText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CameraToolPage(
                          url: 'https://fccadmin.org/server/api/camera-tool',
                        ),
                  ),
                ).then((result) {
                  if (result != null && result is Map && result['data'] != null) {
                    var data = result['data'];

                    // Check if 'width' and 'height' are present and not null
                    var widthStr = data['width'];
                    var heightStr = data['height'];

                    if (widthStr != null && heightStr != null) { // Debugging statement
                      width = widthStr;
                      height = heightStr;

                      if (width != null && height != null) {
                        // Cast to non-nullable
                        final double w = width!;
                        final double h = height!;

                        // Calculate area
                        double area = w * h;
                        String areaStr = area.toStringAsFixed(2); // Keep 2 decimal places

                        // Ensure _controller.text expects a String, not a double
                        setState(() {
                          _controller.text = areaStr; // This is a String
                        });

                        if (widget.onChange != null) {
                          widget.onChange!(areaStr,w.toString(),h.toString()); // areaStr is a String
                        }
                      } else {
                        print("Failed to parse width or height as double.");
                      }
                    } else {
                      print("Width or height is missing in the data.");
                    }
                  } else {
                    print("Result or data is null.");
                  }

                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconColor,
                // Light purple/pink
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
              child: const Text("Auto detect"),
            ),
          ],
        ),
      ],
    );
  }
}
