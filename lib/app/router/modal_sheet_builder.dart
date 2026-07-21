import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  RouteSettings page,
) {
  if (Platform.isIOS) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;

    return CupertinoSheetRoute(
      settings: page,
      scrollableBuilder: (sheetContext, controller) => Theme(
        data: theme,
        child: Material(
          color: surfaceColor,
          child: child,
        ),
      ),
    );
  }

  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true, // Allows sheet to expand based on content
    useSafeArea: true,
  );
}
