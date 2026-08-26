import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/resizable_sheet.dart";

Future<T?> showResizableSheet<T>({
  required BuildContext context,
  required double maxSize,
  required ResizableSheetBuilder builder,
  double? initialSize,
  bool snap = true,
  bool fitMaxSizeToContent = false,
  bool fitToContent = false,
}) async {
  final colors = context.theme.colors;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: colors.surface,
    showDragHandle: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppRadius.large),
        topRight: Radius.circular(AppRadius.large),
      ),
    ),
    builder: (context) => ResizableSheet(
      initialSize: initialSize,
      maxSize: maxSize,
      snap: snap,
      builder: builder,
      fitMaxSizeToContent: fitMaxSizeToContent,
      fitToContent: fitToContent,
    ),
  );
}
