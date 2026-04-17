import 'package:flutter/material.dart';

enum FieldState { default_, error, success }

class CustomFormField extends StatefulWidget {
  final TextEditingController tController;
  final String hint;
  final String label;
  final IconData icon;
  final String errMsg;
  final bool canFocus;
  final TextInputType inputType;
  final VoidCallback? onTap;
  const CustomFormField({
    super.key,
    required this.tController,
    required this.hint,
    required this.label,
    required this.icon,
    required this.errMsg,
    this.canFocus = true,
    this.inputType = TextInputType.text,
    this.onTap,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  FieldState state = FieldState.default_;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    widget.tController.addListener(onControllerChanged);
  }

  void onControllerChanged() {
    if (isFirst) {
      if (widget.tController.text.isNotEmpty) {
        isFirst = false;
      } else {
        return;
      }
    }
    final value = widget.tController.text;
    final newState = value.isEmpty ? FieldState.error : FieldState.success;
    if (newState != state) {
      setState(() => state = newState);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.tController.removeListener(onControllerChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: TextFormField(
        controller: widget.tController,
        keyboardType: widget.inputType,
        canRequestFocus: widget.canFocus,
        onTap: widget.onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          hintText: widget.hint,
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.white60,
          suffixIcon: switch (state) {
            FieldState.error => Icon(Icons.error_outline, color: Colors.red),
            FieldState.success => Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            FieldState.default_ => null,
          },
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: switch (state) {
                FieldState.success => Colors.green,
                FieldState.error => Colors.red,
                FieldState.default_ => Colors.grey,
              },
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: switch (state) {
                FieldState.success => Colors.green,
                FieldState.error => Colors.red,
                _ => Colors.blue,
              },
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorText: state == FieldState.error ? widget.errMsg : null,
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errMsg;
          }
          return null;
        },
      ),
    );
  }
}
