import "package:flutter/material.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/selectable_chip/selectable_chip.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

class CategoryChipsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<Category> categories;
  final Category? selectedCategory;
  final double height;
  final double paddingVertical;
  final double paddingHorizontal;
  final bool isLoading;

  final ValueChanged<Category?> onCategorySelected;

  const CategoryChipsHeaderDelegate({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.height,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.isLoading = false,
  });

  static const double kHeight = 36;
  static const double _chipSeparatorWidth = 10;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final categoriesToRender = isLoading
        ? [Category.loading, Category.loading, Category.loading]
        : categories;

    return Container(
      color: theme.scaffoldBackgroundColor,
      height: height,
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          separatorBuilder: (context, index) {
            return const SizedBox(width: _chipSeparatorWidth);
          },
          itemCount: categoriesToRender.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Skeleton.keep(
                child: SelectableChip(
                  label: Text(l10n.productCatalogAllCategory),
                  onSelected: (_) => onCategorySelected(null),
                  selected: selectedCategory == null,
                ),
              );
            }

            final category = categoriesToRender[index - 1];
            return SelectableChip(
              label: Row(
                spacing: 4,
                children: [
                  Icon(CatalogIcon.fromName(category.iconKey).icon, size: 14),
                  Text(category.label),
                ],
              ),
              onSelected: (_) => onCategorySelected(category),
              selected: selectedCategory?.id == category.id,
            );
          },
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CategoryChipsHeaderDelegate oldDelegate) {
    return oldDelegate.selectedCategory != selectedCategory ||
        oldDelegate.categories != categories ||
        oldDelegate.isLoading != isLoading;
  }
}
