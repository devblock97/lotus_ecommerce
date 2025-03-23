import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LotusMarketForm extends StatefulWidget {
  const LotusMarketForm({
    super.key,
    required this.label,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false
  });

  final String label;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool obscureText;

  @override
  State<LotusMarketForm> createState() => _LotusMarketFormState();
}

class _LotusMarketFormState extends State<LotusMarketForm> {
  bool isValidate = false;
  Timer? _debounce;

  final commonBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: theme.textTheme.titleSmall,
        labelText: widget.label,
        border: commonBorder,
        enabledBorder: commonBorder,
        focusedBorder: commonBorder,
        disabledBorder: commonBorder,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.obscureText,
    );
  }
}