import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";

/// Returns `true` to close the sheet, `false` to keep it open (e.g. on error).
typedef CategoryEditSheetOnEditCallback =
    Future<bool> Function(CategoryWithProductsCount updatedCategory);

Future<void> showCategoryEditSheet({
  required BuildContext context,
  required CategoryEditSheetOnEditCallback onEdit,
  required CategoryWithProductsCount category,
}) {
  return showResizableSheet<void>(
    context: context,
    maxSize: 0.9,
    fitToContent: true,
    builder: (context, scrollController, sheetController) {
      return CategoryEditSheetView(
        scrollController: scrollController,
        onEdit: onEdit,
        category: category,
      );
    },
  );
}

class CategoryEditSheetView extends StatefulWidget {
  const CategoryEditSheetView({
    super.key,
    required this.scrollController,
    required this.onEdit,
    required this.category,
  });

  final ScrollController scrollController;
  final CategoryEditSheetOnEditCallback onEdit;
  final CategoryWithProductsCount category;

  @override
  State<CategoryEditSheetView> createState() => _CategoryEditSheetViewState();
}

class _CategoryEditSheetViewState extends State<CategoryEditSheetView> {
  late final ValueNotifier<CatalogIcons?> _selectedIcon = ValueNotifier(
    CatalogIcons.values.byName(widget.category.iconKey),
  );
  final ValueNotifier<bool> _isPending = ValueNotifier(false);
  late final TextEditingController _labelController = TextEditingController(
    text: widget.category.label,
  );

  void _onIconSelected(CatalogIcons? icon) {
    if (icon == null) return;
    _selectedIcon.value = icon;
  }

  Future<void> _onEditPressed() async {
    if (_isPending.value) return;

    _isPending.value = true;
    try {
      final shouldClose = await widget.onEdit(
        CategoryWithProductsCount(
          id: widget.category.id,
          label: _labelController.text,
          iconKey: _selectedIcon.value!.name,
          productsCount: widget.category.productsCount,
        ),
      );
      if (shouldClose && mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        _isPending.value = false;
      }
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _selectedIcon.dispose();
    _isPending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final inputDecoration = AppInputDecoration(
      context: context,
      hintText: l10n.name,
    );
    final buttonStyles = ButtonStyles.of(context);

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.containerHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: colors.surface,
              padding: const EdgeInsets.only(
                top: AppSpacing.xLarge,
                bottom: AppSpacing.large,
              ),
              child: Text(
                l10n.editCategory,
                style: AppTypography.textTheme.titleLarge!.copyWith(
                  fontFamily: AppFonts.manrope,
                ),
              ),
            ),

            Row(
              spacing: AppSpacing.small,
              children: [
                ValueListenableBuilder(
                  valueListenable: _selectedIcon,
                  builder: (context, icon, _) => Button(
                    style: icon != null
                        ? buttonStyles.secondarySelected
                        : buttonStyles.secondary,
                    size: ButtonSizes.icon,
                    rounder: ButtonRounders.rectangular.copyWith(
                      borderRadius: inputDecoration.shape.borderRadius,
                    ),
                    onPressed: () {
                      showCatalogIconsPickerSheet(
                        context: context,
                        initialSelectedCatalogIcon: icon,
                      ).then(_onIconSelected);
                    },
                    child: icon != null
                        ? Icon(icon.icon, size: 20)
                        : Icon(LucideIcons.tag, size: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _labelController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: inputDecoration.toInputDecoration(),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.standard),
            ListenableBuilder(
              listenable: Listenable.merge([
                _selectedIcon,
                _labelController,
                _isPending,
              ]),
              builder: (context, _) {
                final isPending = _isPending.value;
                final isEmpty =
                    _labelController.text.isEmpty ||
                    _selectedIcon.value == null;
                final isSameAsOriginal =
                    _labelController.text == widget.category.label &&
                    _selectedIcon.value!.name == widget.category.iconKey;
                final isDisabled = isPending || isEmpty || isSameAsOriginal;

                return Button(
                  disabled: isDisabled,
                  onPressed: _onEditPressed,
                  child: Row(
                    mainAxisAlignment: .center,
                    spacing: AppSpacing.xSmall,
                    children: [Text(l10n.edit)],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
