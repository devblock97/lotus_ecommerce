import 'package:ecommerce_app/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

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
        return const SkeletonLoading();
      },
    );
  }
}


class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Skeleton(
          height: 20,
        ),
        Gap(10),
        Skeleton(
          width: 120,
          height: 120,
        ),
        Gap(10),
        Skeleton(height: 20,),
        Gap(10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Skeleton(height: 20)),
            Gap(10),
            Expanded(child: Skeleton(height: 20,))
          ],
        )
      ],
    );
  }
}