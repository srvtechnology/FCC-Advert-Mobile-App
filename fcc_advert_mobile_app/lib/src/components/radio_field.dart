import 'package:fcc_advert_mobile_app/src/components/radio_button.dart';
import 'package:flutter/material.dart';


class RadioField extends StatefulWidget {
  final List<String> propertyTypes;
  final String title;
  final void Function(String)? onButtonTap;
  const RadioField({
    super.key,
    required this.propertyTypes,
    required this.title,
    this.onButtonTap
  });

  @override
  State<RadioField> createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  String selectedType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          widget.title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.propertyTypes.map((type) {
            return CustomRadioButton(
              isSelected: selectedType == type,
              label: type,
              onTap: () {
                setState(() {
                  selectedType = type;
                });
                if(widget.onButtonTap != null){
                  widget.onButtonTap!(selectedType);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
