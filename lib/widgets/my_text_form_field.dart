import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

@immutable
class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.label,
      this.leadingIcon,
      this.trailingIcon,
      this.controller,
      this.validator,
      this.obscureText = false});

  final String label;
  final Icon? trailingIcon;
  final Icon? leadingIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: leadingIcon,
        suffixIcon: trailingIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
        )
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
