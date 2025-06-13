import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/colors.dart';
import '../constants/form.dart';
import '../types/form.dart';

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
    this.dropdownData,
  }) : assert(
  onSuffixIconTap == null || buttonType != null,
  'If On SuffixIconTap is provided, buttonType must not be null',
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

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
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
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIconInside == null || widget.buttonType == null) return null;

    switch (widget.buttonType) {
      case 'calendar':
        return IconButton(
          icon: Icon(widget.suffixIconInside, color: AppColors.iconColor),
          onPressed: () async {
            if (widget.onSuffixIconTap != null) {
              final value = await _selectDate(context);
              if (value != null) {
                final formattedDate = DateFormat('dd/MM/yyyy').format(value);
                setState(() {
                  _controller.text = formattedDate;
                });
                widget.onSuffixIconTap!(value.toString());
              }
            }
          },
        );

      case 'dropdown':
        return IconButton(
          icon: Icon(widget.suffixIconInside, color: AppColors.iconColor),
          onPressed: () async {
            final selected = await showModalBottomSheet<OptionItem>(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.primaryBackground,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: widget.dropdownData?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = widget.dropdownData![index];
                        return ListTile(
                          title: Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );

            if (selected != null) {
              setState(() {
                _controller.text = selected.name;
              });
              widget.onSuffixIconTap?.call(selected);
            }
          },
        );

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
        if (!widget.disableLabel!) ...[
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
                readOnly: widget.buttonType == "dropdown" ? true : false,
                keyboardType: _getKeyboardType(),
                inputFormatters: widget.type == TextFieldTypeEnum.number ? [] : [],
                controller: _controller,
                onChanged: (value) {
                  if ((widget.buttonType == null || widget.suffixIconInside == null) &&
                      widget.onTextChanged != null) {
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
                icon: Icon(
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
