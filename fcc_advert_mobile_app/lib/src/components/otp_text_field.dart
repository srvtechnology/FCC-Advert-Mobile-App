import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onBackspace;

  const OTPTextField({
    required this.controller,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    this.onBackspace,
  });

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  String _previousValue = '';

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (_previousValue.isNotEmpty && widget.controller.text.isEmpty) {
      // Text was deleted (likely backspace)
      widget.onBackspace?.call();
    }
    _previousValue = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFF1A2F9), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
            widget.onBackspace?.call();
          }
        },
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            counter: Offstage(),
            border: InputBorder.none,
          ),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }
}