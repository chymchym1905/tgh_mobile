import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;
  final double radius;
  const ShimmerComponent.sharpregtangular({super.key, this.width, this.height, this.radius = 10})
      : shapeBorder = const RoundedRectangleBorder();
  ShimmerComponent.regtangular({super.key, this.width, this.height, this.radius = 10})
      : shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius)));
  const ShimmerComponent.circular(
      {super.key, this.width, this.height, this.shapeBorder = const CircleBorder(), this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.outline,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(shape: shapeBorder, color: Theme.of(context).colorScheme.surfaceContainerLowest),
      ),
    );
  }
}
