import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';

class EcommerceButton extends StatelessWidget {
  EcommerceButton(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.titleColor,
      this.elevation = 0,
      required this.onTap});

  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: const EdgeInsets.all(22),
          backgroundColor: backgroundColor ?? primaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          minimumSize: const Size.fromHeight(50)),
      child: Text(title,
          style: TextStyle(
              color: titleColor, fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
