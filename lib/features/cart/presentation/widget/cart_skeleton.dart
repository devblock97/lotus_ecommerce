
import 'package:ecommerce_app/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListCartSkeleton extends StatelessWidget {
  const ListCartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(0.4)
          ),
          child: const CartSkeleton()
        );
      },
    );
  }
}


class CartSkeleton extends StatelessWidget {
  const CartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 1,
          child: Skeleton(
            width: 110,
            height: 110,
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Skeleton(
                width: double.infinity,
                height: 30,
              ),
              Gap(10),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Skeleton(
                      width: double.infinity,
                      height: 30,
                    ),
                  ),
                  Gap(10),
                  Flexible(
                    flex: 3,
                    child: Skeleton(
                      width: double.infinity,
                      height: 30,
                    ),
                  )
                ],
              ),
              Gap(10),
              Skeleton(
                width: double.infinity,
                height: 30,
              )
            ],
          ),
        )
      ],
    );
  }
}
