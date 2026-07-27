import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

const _maxSheetSize = 0.9;

Future<bool?> showCategoryDeleteSheet({
  required BuildContext context,
  required CategoryWithProductsCount category,
  required Future<bool> Function() onDelete,
}) async {
  final isCategoryHasLinkedProducts = category.productsCount > 0;

  return showResizableSheet<bool>(
    context: context,
    maxSize: _maxSheetSize,
    fitToContent: true,
    builder: (context, scrollController, sheetController) =>
        CategoryDeleteSheetView(
          category: category,
          onDelete: onDelete,
          isCategoryHasLinkedProducts: isCategoryHasLinkedProducts,
          scrollController: scrollController,
        ),
  );
}

class CategoryDeleteSheetView extends StatefulWidget {
  const CategoryDeleteSheetView({
    super.key,
    required this.category,
    required this.onDelete,
    required this.isCategoryHasLinkedProducts,
    required this.scrollController,
  });

  final CategoryWithProductsCount category;
  final Future<bool> Function() onDelete;
  final bool isCategoryHasLinkedProducts;
  final ScrollController scrollController;

  @override
  State<CategoryDeleteSheetView> createState() =>
      _CategoryDeleteSheetViewState();
}

class _CategoryDeleteSheetViewState extends State<CategoryDeleteSheetView> {
  final ValueNotifier<bool> _isPending = ValueNotifier(false);

  Future<void> _onDeletePressed() async {
    _isPending.value = true;
    try {
      final result = await widget.onDelete();
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
    final l10n = AppLocalizations.of(context)!;
    final description = widget.isCategoryHasLinkedProducts
        ? l10n.deleteCategoryWithProductsBoundedDescription
        : l10n.deleteCategoryDescription;

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
              color: AppColors.surface,
              padding: const EdgeInsets.only(
                top: AppSpacing.xLarge,
                bottom: AppSpacing.large,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    l10n.deleteCategory,
                    style: AppTypography.textTheme.titleLarge!.copyWith(
                      fontFamily: AppFonts.manrope,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTypography.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
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
                    style: ButtonStyles.ghost,
                    onPressed: _onCancelPressed,
                    child: Text(l10n.cancel, textAlign: .center),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isPending,
                  builder: (context, value, child) {
                    return Expanded(
                      child: Button(
                        style: ButtonStyles.destructiveGhost,
                        disabled: value || widget.isCategoryHasLinkedProducts,
                        onPressed: _onDeletePressed,
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
