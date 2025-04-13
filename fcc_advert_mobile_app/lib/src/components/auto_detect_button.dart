import 'package:flutter/material.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';

class AdvertisementAreaInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAutoDetect;
  final void Function(String)? onChange;

  const AdvertisementAreaInput({
    super.key,
    this.onChange,
    required this.controller,
    required this.onAutoDetect,
  });

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
            color:AppColors.text
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value){
                  if(onChange != null){
                    onChange!(value);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: "Enter the name",
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
              onPressed: (){
                onAutoDetect();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconColor, // Light purple/pink
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
