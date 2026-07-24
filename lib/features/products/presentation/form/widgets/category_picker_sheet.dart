import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/category_with_products_count.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/widgets/widgets.dart";

Future<CategoryWithProductsCount?> showCategoryPickerSheet({
  required BuildContext context,
  required List<CategoryWithProductsCount> categories,
}) async {
  return showResizableSheet(
    context: context,
    initialSize: 0.45,
    maxSize: 0.9,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, _) => CategoryPickerSheetView(
      categories: categories,
      scrollController: scrollController,
    ),
  );
}

class CategoryPickerSheetView extends StatefulWidget {
  const CategoryPickerSheetView({
    super.key,
    required this.categories,
    required this.scrollController,
  });

  final List<CategoryWithProductsCount> categories;
  final ScrollController scrollController;

  @override
  State<CategoryPickerSheetView> createState() =>
      _CategoryPickerSheetViewState();
}

class _CategoryPickerSheetViewState extends State<CategoryPickerSheetView> {
  final ValueNotifier<CategoryWithProductsCount?> selectedCategory =
      ValueNotifier(null);

  void _onCategorySelected(CategoryWithProductsCount category) {
    selectedCategory.value = category;
  }

  void _onSelectPressed() {
    Navigator.pop(context, selectedCategory.value);
  }

  @override
  void dispose() {
    selectedCategory.dispose();
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
                SliverList.builder(
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    final category = widget.categories[index];

                    return CategoryTile(
                      selected: selectedCategory.value?.id == category.id,
                      category: category,
                      onPressed: () => _onCategorySelected(category),
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
