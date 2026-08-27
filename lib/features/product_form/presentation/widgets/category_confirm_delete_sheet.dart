import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";

const _maxSheetSize = 0.9;

Future<bool?> showCategoryConfirmDeleteSheet({
  required BuildContext context,
  required CategoryWithProductsCount category,
  required Future<bool> Function() onConfirm,
}) async {
  final isCategoryHasLinkedProducts = category.productsCount > 0;

  return showResizableSheet<bool>(
    context: context,
    maxSize: _maxSheetSize,
    fitToContent: true,
    builder: (context, scrollController, sheetController) =>
        CategoryConfirmDeleteSheetView(
          category: category,
          onConfirm: onConfirm,
          isCategoryHasLinkedProducts: isCategoryHasLinkedProducts,
          scrollController: scrollController,
        ),
  );
}

class CategoryConfirmDeleteSheetView extends StatefulWidget {
  const CategoryConfirmDeleteSheetView({
    required this.category,
    required this.onConfirm,
    required this.isCategoryHasLinkedProducts,
    required this.scrollController,
    super.key,
  });

  final CategoryWithProductsCount category;
  final Future<bool> Function() onConfirm;
  final bool isCategoryHasLinkedProducts;
  final ScrollController scrollController;

  @override
  State<CategoryConfirmDeleteSheetView> createState() =>
      _CategoryConfirmDeleteSheetViewState();
}

class _CategoryConfirmDeleteSheetViewState
    extends State<CategoryConfirmDeleteSheetView> {
  final ValueNotifier<bool> _isPending = ValueNotifier(false);

  Future<void> _onConfirmPressed() async {
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

  void _onCancelPressed() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _isPending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;
    final description = widget.isCategoryHasLinkedProducts
        ? l10n.deleteCategoryWithProductsBoundedDescription
        : l10n.deleteCategoryDescription;
    final buttonStyles = ButtonStyles.of(context);

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.containerHorizontal,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              color: colors.surface,
              padding: const EdgeInsets.only(
                top: AppSpacing.xLarge,
                bottom: AppSpacing.standard,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    l10n.deleteCategory,
                    style: text.headingLg.copyWith(
                      fontFamily: AppFonts.manrope,
                    ),
                  ),
                  Text(
                    description,
                    style: text.bodySm.copyWith(color: colors.textSecondary),
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
                    child: Text(l10n.cancel, textAlign: .center),
                  ),
                ),
                if (!widget.isCategoryHasLinkedProducts)
                  ValueListenableBuilder(
                    valueListenable: _isPending,
                    builder: (context, value, child) {
                      return Expanded(
                        child: Button(
                          style: buttonStyles.destructiveGhost,
                          disabled: value || widget.isCategoryHasLinkedProducts,
                          onPressed: _onConfirmPressed,
                          child: Text(l10n.delete, textAlign: .center),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
