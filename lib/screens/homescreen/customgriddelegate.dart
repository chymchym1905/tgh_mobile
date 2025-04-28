import 'dart:developer';

import 'package:flutter/rendering.dart';

class CustomGridDelegate extends SliverGridDelegate {
  final int crossAxisCount;
  final double spacing;

  const CustomGridDelegate({required this.crossAxisCount, this.spacing = 8});

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final childWidth = (constraints.crossAxisExtent - (crossAxisCount - 1) * spacing) / crossAxisCount;
    var childHeight = childWidth * 1.2;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childHeight + spacing,
      crossAxisStride: childWidth + spacing,
      childMainAxisExtent: childHeight,
      childCrossAxisExtent: childWidth,
      reverseCrossAxis: false,
    );
  }

  @override
  bool shouldRelayout(covariant CustomGridDelegate oldDelegate) {
    log("shouldRelayout ${oldDelegate.crossAxisCount != crossAxisCount || oldDelegate.spacing != spacing}",
        name: 'CustomGridDelegate');
    return oldDelegate.crossAxisCount != crossAxisCount || oldDelegate.spacing != spacing;
  }
}
