import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

Future<bool?> showProductConfirmDeleteSheet({
  required BuildContext context,
  required Future<bool> Function() onConfirm,
}) async {
  return showResizableSheet<bool>(
    context: context,
    maxSize: 0.9,
    fitToContent: true,
    builder: (context, scrollController, sheetController) =>
        ProductConfirmDeleteSheetView(
          scrollController: scrollController,
          onConfirm: onConfirm,
        ),
  );
}

class ProductConfirmDeleteSheetView extends StatefulWidget {
  const ProductConfirmDeleteSheetView({
    super.key,
    required this.scrollController,
    required this.onConfirm,
  });

  final ScrollController scrollController;
  final Future<bool> Function() onConfirm;

  @override
  State<ProductConfirmDeleteSheetView> createState() =>
      _ProductConfirmDeleteSheetViewState();
}

class _ProductConfirmDeleteSheetViewState
    extends State<ProductConfirmDeleteSheetView> {
  final ValueNotifier<bool> _isPending = ValueNotifier(false);

  void _onCancelPressed() {
    Navigator.pop(context, false);
  }

  void _onConfirmPressed() async {
    _isPending.value = true;

    try {
      final result = await widget.onConfirm();
      if (result && mounted) {
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) {
        _isPending.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final buttonStyles = ButtonStyles.of(context);

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: AppSpacing.xLarge,
                bottom: AppSpacing.large,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.productConfirmDeleteSheetTitle,
                    style: AppTypography.textTheme.titleLarge!.copyWith(
                      fontFamily: AppFonts.manrope,
                    ),
                  ),
                  Text(
                    l10n.productConfirmDeleteSheetDescription,
                    style: AppTypography.textTheme.bodyMedium!.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: AppSpacing.small,
              children: [
                Expanded(
                  child: Button(
                    style: buttonStyles.ghost,
                    onPressed: _onCancelPressed,
                    child: Text(l10n.cancel, textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _isPending,
                    builder: (context, isPending, child) {
                      return Button(
                        style: buttonStyles.destructiveGhost,
                        disabled: isPending,
                        onPressed: _onConfirmPressed,
                        child: Text(l10n.delete, textAlign: TextAlign.center),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
