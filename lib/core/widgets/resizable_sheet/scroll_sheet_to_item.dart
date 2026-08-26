import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

/// Main-axis extent of one cell for
/// [SliverGridDelegateWithFixedCrossAxisCount].
double gridItemExtent({
  required double crossAxisExtent,
  required int crossAxisCount,
  double crossAxisSpacing = 0,
  double childAspectRatio = 1,
}) {
  assert(crossAxisCount > 0, "crossAxisCount must be greater than 0");
  assert(childAspectRatio > 0, "childAspectRatio must be greater than 0");
  final cellCrossAxisExtent =
      (crossAxisExtent - (crossAxisCount - 1) * crossAxisSpacing) /
      crossAxisCount;
  return cellCrossAxisExtent / childAspectRatio;
}

/// Cross-axis extent of the scrollable viewport (width for a vertical scroll).
double? scrollableCrossAxisExtent(ScrollController scrollController) {
  if (!scrollController.hasClients) {
    return null;
  }

  final box = scrollController.position.context.notificationContext
      ?.findRenderObject();
  if (box is! RenderBox || !box.hasSize) {
    return null;
  }

  return scrollController.position.axis == Axis.vertical
      ? box.size.width
      : box.size.height;
}

/// Expands a [DraggableScrollableSheet] to [maxSheetSize] if needed, then
/// scrolls so that [index] is centered in the viewport.
///
/// Position is computed from layout math — safe for lazy builders where
/// off-screen items are not mounted yet (GlobalKey would be null / size 0).
///
/// - List: `crossAxisCount: 1`,
///   [itemExtent] = item height along the scroll axis.
/// - Grid: [itemExtent] = cell main-axis size (see [gridItemExtent]).
Future<void> scrollSheetToItem({
  required ScrollController scrollController,
  required DraggableScrollableController sheetController,
  required int index,
  required double itemExtent,
  required double maxSheetSize,
  int crossAxisCount = 1,
  double mainAxisSpacing = 0,
  Duration duration = AppDuration.main,
  Curve curve = Curves.easeInOut,
}) async {
  if (index < 0 || itemExtent <= 0 || !scrollController.hasClients) {
    return;
  }

  final row = index ~/ crossAxisCount;
  final itemTop = row * (itemExtent + mainAxisSpacing);
  final itemBottom = itemTop + itemExtent;

  var position = scrollController.position;

  // Already fully visible — nothing to do.
  if (itemBottom <= position.viewportDimension) {
    return;
  }

  // Expand the sheet first: once the inner list is scrolled away from the
  // top, dragging can no longer expand the sheet.
  if (sheetController.isAttached) {
    await sheetController.animateTo(
      maxSheetSize,
      duration: duration,
      curve: curve,
    );
  }

  if (!scrollController.hasClients) {
    return;
  }

  position = scrollController.position;

  // Expanding the sheet alone made the item visible.
  if (itemBottom <= position.viewportDimension) {
    return;
  }

  final target = (itemTop - (position.viewportDimension - itemExtent) / 2)
      .clamp(0.0, position.maxScrollExtent);

  await scrollController.animateTo(target, duration: duration, curve: curve);
}
