import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Theme.of(context).colorScheme.primary,
      baseColor: Theme.of(context).colorScheme.secondary,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary
        ),
      ),
    );
  }
}