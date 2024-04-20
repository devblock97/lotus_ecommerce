import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkelton extends StatelessWidget {
  const ProductSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.7
      ),
      itemBuilder: (BuildContext context, int index) {
        return const SkeltonLoading();
      },
    );
  }
}


class SkeltonLoading extends StatelessWidget {
  const SkeltonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Skelton(
          height: 20,
        ),
        Gap(10),
        Skelton(
          width: 120,
          height: 120,
        ),
        Gap(10),
        Skelton(height: 20,),
        Gap(10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Skelton(height: 20)),
            Gap(10),
            Expanded(child: Skelton(height: 20,))
          ],
        )
      ],
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.width,
    this.height
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey,
      baseColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.1)
        ),
      ),
    );
  }
}