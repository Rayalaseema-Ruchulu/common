import 'package:flutter/rendering.dart';

class FixedHeightGridDelegate extends SliverGridDelegate {
  const FixedHeightGridDelegate({
    required this.minItemWidth,
    required this.fixedItemHeight,
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
  }) : assert(minItemWidth > 0),
       assert(fixedItemHeight > 0),
       assert(mainAxisSpacing >= 0),
       assert(crossAxisSpacing >= 0);

  final double minItemWidth;
  final double fixedItemHeight;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent -
        crossAxisSpacing; // Account for spacing on one side

    int crossAxisCount =
        (usableCrossAxisExtent + crossAxisSpacing) ~/
        (minItemWidth + crossAxisSpacing);
    if (crossAxisCount == 0) {
      crossAxisCount = 1; // Ensure at least one item per row
    }

    final double childCrossAxisExtent =
        (usableCrossAxisExtent - (crossAxisCount - 1) * crossAxisSpacing) /
        crossAxisCount;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: fixedItemHeight + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childCrossAxisExtent: childCrossAxisExtent,
      childMainAxisExtent:
          fixedItemHeight, // This is where we apply the fixed height
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(FixedHeightGridDelegate oldDelegate) {
    return oldDelegate.minItemWidth != minItemWidth ||
        oldDelegate.fixedItemHeight != fixedItemHeight ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing;
  }
}
