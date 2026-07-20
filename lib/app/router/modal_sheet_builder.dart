import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  RouteSettings page,
) {
  if (Platform.isIOS) {
    return CupertinoSheetRoute(
      settings: page,
      scrollableBuilder: (context, controller) => child,
    );
  }

  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true, // Allows sheet to expand based on content
    useSafeArea: true,
  );
}
