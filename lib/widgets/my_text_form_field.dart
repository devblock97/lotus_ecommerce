import 'package:flutter/material.dart';

@immutable
class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
      required this.label,
      this.leadingIcon,
      this.trailingIcon,
      this.controller,
      this.obscureText = false});

  final String label;
  final Icon? trailingIcon;
  final Icon? leadingIcon;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          prefixIcon: leadingIcon,
          suffixIcon: trailingIcon),
      obscureText: obscureText,
    );
  }
}
