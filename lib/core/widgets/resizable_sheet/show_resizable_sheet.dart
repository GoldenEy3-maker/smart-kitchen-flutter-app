import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/resizable_sheet.dart";

Future<T?> showResizableSheet<T>({
  required BuildContext context,
  required double initialSize,
  required double maxSize,
  bool snap = true,
  required ResizableSheetBuilder builder,
  bool fitMaxSizeToContent = false,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
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
    ),
  );
}
