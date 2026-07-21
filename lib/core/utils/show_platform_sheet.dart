import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

Future<T?> showPlatformSheet<T>({
  required BuildContext context,
  required Widget child,
}) async {
  if (Platform.isIOS) {
    return showCupertinoSheet<T>(
      context: context,
      scrollableBuilder: (context, controller) => child,
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
