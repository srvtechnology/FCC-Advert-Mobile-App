import 'package:fcc_advert_mobile_app/src/constants/form.dart';
import 'package:fcc_advert_mobile_app/src/types/form.dart';
import 'package:flutter/material.dart';
import 'package:fcc_advert_mobile_app/src/config/colors.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CustomTextField extends StatefulWidget {
  final String? label;
  final String hintText;
  final String? buttonType;
  final TextFieldTypeEnum? type;
  final IconData? suffixIconInside;
  final void Function(dynamic)? onSuffixIconTap;
  final IconData? trailingIconOutside;
  final void Function(String)? onTrailingIconTap;
  final void Function(String)? onTextChanged;
  final String? value;
  final bool? disableLabel;
  final List<OptionItem>? dropdownData;

  const CustomTextField({
    super.key,
    this.label,
    required this.hintText,
    this.suffixIconInside,
    this.onSuffixIconTap,
    this.trailingIconOutside,
    this.onTrailingIconTap,
    this.buttonType,
    this.onTextChanged,
    this.type,
    this.value,
    this.disableLabel = false,
    this.dropdownData
  }):assert(
    onSuffixIconTap==null || buttonType!=null,
    'If On SuffixIconTap is provided, buttonType must not be null'
  );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? "");
  }

  void setText(String value) {
    setState(() {
      _controller.text = value;
    });
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
  }

  String getText() {
    return _controller.text;
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    return picked;

    // if (picked != null) {
    //   final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
    //   return formattedDate;
    // }

    return null;
  }
  Widget? _buildSuffixIcon() {
    if (widget.suffixIconInside == null || widget.buttonType == null) return null;

    switch (widget.buttonType) {
      case 'calendar':
        return IconButton(
          icon: Icon(widget.suffixIconInside, color: AppColors.iconColor),
          onPressed: () async{
            if (widget.onSuffixIconTap != null) {
              final value = await _selectDate(context);
              setState(() {
                _controller.text = value.toString();
              });
              widget.onSuffixIconTap!(_controller.text);
            }
          },
        );

      case 'dropdown':
        return PopupMenuButton<OptionItem>(
          color: AppColors.primaryBackground,
          icon: Icon(widget.suffixIconInside, color: AppColors.iconColor),
          onSelected: (value) {
            setState(() {
              _controller.text = value.name;
            });
            widget.onSuffixIconTap!(value);
          },
          itemBuilder: (BuildContext context) {
            return widget.dropdownData!
                .map((e) => PopupMenuItem<OptionItem>(
              value: e,
              child: Text(e.name),
            ))
                .toList();
          },
        );

      case 'iconbutton':
      default:
        return IconButton(
          icon: Icon(widget.suffixIconInside, color: AppColors.iconColor),
          onPressed: () {
            if (widget.onSuffixIconTap != null) {
              widget.onSuffixIconTap!(_controller.text);
            }
          },
        );
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case TextFieldTypeEnum.email:
        return TextInputType.emailAddress;
      case TextFieldTypeEnum.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasOutsideIcon = widget.trailingIconOutside != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(!widget.disableLabel!)...[
          Text(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 5),
        ],
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: _getKeyboardType(),
                inputFormatters: widget.type == TextFieldTypeEnum.number
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                controller: _controller,
                onChanged: (value) {
                  if ((widget.buttonType == null || widget.suffixIconInside == null) && widget.onTextChanged != null) {
                    widget.onTextChanged!(value);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: widget.hintText,
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
                  suffixIcon: _buildSuffixIcon(),
                ),
              ),
            ),
            if (hasOutsideIcon) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (widget.onTrailingIconTap != null) {
                    widget.onTrailingIconTap!(_controller.text);
                  }
                },
                icon:  Icon(
                  widget.trailingIconOutside,
                  color: AppColors.iconColor,
                  size: 30,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
