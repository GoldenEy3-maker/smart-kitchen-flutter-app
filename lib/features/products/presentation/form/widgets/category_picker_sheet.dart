import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/category_with_products_count.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/widgets/widgets.dart";

const _maxSheetSize = 0.9;
const _initialSheetSize = 0.46;

Future<CategoryWithProductsCount?> showCategoryPickerSheet({
  required BuildContext context,
  required List<CategoryWithProductsCount> categories,
  CategoryWithProductsCount? initialSelectedCategory,
}) async {
  return showResizableSheet(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) =>
        CategoryPickerSheetView(
          categories: categories,
          scrollController: scrollController,
          sheetController: sheetController,
          initialSelectedCategory: initialSelectedCategory,
        ),
  );
}

class CategoryPickerSheetView extends StatefulWidget {
  const CategoryPickerSheetView({
    super.key,
    required this.categories,
    required this.scrollController,
    required this.sheetController,
    required this.initialSelectedCategory,
  });

  final List<CategoryWithProductsCount> categories;
  final ScrollController scrollController;
  final DraggableScrollableController sheetController;
  final CategoryWithProductsCount? initialSelectedCategory;

  @override
  State<CategoryPickerSheetView> createState() =>
      _CategoryPickerSheetViewState();
}

class _CategoryPickerSheetViewState extends State<CategoryPickerSheetView> {
  late final ValueNotifier<CategoryWithProductsCount?> _selectedCategory =
      ValueNotifier(widget.initialSelectedCategory);
  final _initialSelectedCategoryKey = GlobalKey();

  void _onCategorySelected(CategoryWithProductsCount category) {
    _selectedCategory.value = category;
  }

  void _onSelectPressed() {
    Navigator.pop(context, _selectedCategory.value);
  }

  void _onEditPressed(CategoryWithProductsCount category) {
    print('onEditPressed: $category');
  }

  void _onDeletePressed(CategoryWithProductsCount category) {
    showCategoryDeleteSheet(
      context: context,
      category: category,
      onDelete: () async {
        await Future.delayed(const Duration(seconds: 1));
        return false;
      },
    );
  }

  Future<void> _scrollToSelectedCategory() async {
    final selectedCategory = _selectedCategory.value;

    if (!mounted ||
        selectedCategory == null ||
        !widget.scrollController.hasClients) {
      return;
    }

    final selectedItemIndex = widget.categories.indexOf(selectedCategory);
    final selectedItemHeight =
        _initialSelectedCategoryKey.currentContext?.size?.height ?? 0;
    final offsetTop = selectedItemIndex * selectedItemHeight;
    final offsetBottom = offsetTop + selectedItemHeight;
    final scrollPosition = widget.scrollController.position;

    // Already fully visible - nothing to do.
    if (offsetBottom <= scrollPosition.viewportDimension) {
      return;
    }

    if (widget.sheetController.isAttached) {
      await widget.sheetController.animateTo(
        _maxSheetSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    // Already fully visible - nothing to do.
    if (offsetBottom <= scrollPosition.viewportDimension) {
      return;
    }

    final target =
        (offsetTop -
                (scrollPosition.viewportDimension - selectedItemHeight) / 2)
            .clamp(0.0, scrollPosition.maxScrollExtent);

    await widget.scrollController.animateTo(
      target,
      duration: const Duration(microseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedCategory();
    });
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.medium,
            ),
            child: Text(
              l10n.selectCategory,
              style: AppTypography.textTheme.titleLarge!.copyWith(
                fontFamily: AppFonts.manrope,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                ValueListenableBuilder(
                  valueListenable: _selectedCategory,
                  builder: (context, value, child) {
                    return SliverList.builder(
                      itemCount: widget.categories.length,
                      itemBuilder: (context, index) {
                        final category = widget.categories[index];
                        final isSelected = value?.id == category.id;
                        final isInitialSelected =
                            category.id == widget.initialSelectedCategory?.id;

                        final tile = CategoryTile(
                          key: ValueKey(category.id),
                          selected: isSelected,
                          category: category,
                          onPressed: () => _onCategorySelected(category),
                          onEditPressed: () => _onEditPressed(category),
                          onDeletePressed: () => _onDeletePressed(category),
                        );

                        if (isInitialSelected) {
                          return KeyedSubtree(
                            key: _initialSelectedCategoryKey,
                            child: tile,
                          );
                        }

                        return tile;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
            child: Button(
              onPressed: _onSelectPressed,
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
