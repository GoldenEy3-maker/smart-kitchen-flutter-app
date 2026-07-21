import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

Future<T?> showPlatformSheet<T>({
  required BuildContext context,
  Widget Function(BuildContext context, ScrollController controller)? builder,

  /// iOS: gap from top as a ratio of screen height (0.5 ≈ half-screen sheet).
  /// Android: limits max sheet height via [showModalBottomSheet] constraints.
  double? topGap,
  bool showDragHandle = false,
  Color? backgroundColor,
}) async {
  final sheetHeightFactor = topGap != null ? 1 - topGap : null;

  if (Platform.isIOS) {
    final theme = Theme.of(context);
    final surfaceColor = backgroundColor ?? theme.colorScheme.surface;

    return showCupertinoSheet<T>(
      context: context,
      topGap: topGap,
      showDragHandle: showDragHandle,
      scrollableBuilder: (sheetContext, controller) {
        return Theme(
          data: theme,
          child: Material(
            color: surfaceColor,
            child:
                builder?.call(sheetContext, controller) ??
                const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: sheetHeightFactor != null,
    useSafeArea: true,
    showDragHandle: showDragHandle,
    backgroundColor: backgroundColor,
    constraints: sheetHeightFactor != null
        ? BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * sheetHeightFactor,
          )
        : null,
    builder: (BuildContext context) {
      final scrollController = ScrollController();

      return _DismissibleScrollSheet(
        child:
            builder?.call(context, scrollController) ?? const SizedBox.shrink(),
      );
    },
  );
}

/// Closes the sheet when the user pulls down while scroll content is at the top.
///
/// [DraggableScrollableSheet] is meant for resizable sheets. For a fixed-height
/// scrollable modal, use [showPlatformSheet] with this wrapper instead.
class _DismissibleScrollSheet extends StatelessWidget {
  const _DismissibleScrollSheet({required this.child});

  final Widget child;

  bool _isAtTop(ScrollMetrics metrics) =>
      metrics.pixels <= metrics.minScrollExtent;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!_isAtTop(notification.metrics)) {
          return false;
        }

        if (notification is OverscrollNotification &&
            notification.overscroll < 0) {
          Navigator.of(context).pop();
          return true;
        }

        if (notification is ScrollUpdateNotification &&
            notification.dragDetails != null &&
            (notification.scrollDelta ?? 0) < 0) {
          Navigator.of(context).pop();
          return true;
        }

        return false;
      },
      child: child,
    );
  }
}
