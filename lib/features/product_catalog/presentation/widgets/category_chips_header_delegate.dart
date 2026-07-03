import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";

class CategoryChipsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<Category> categories;
  final Category? selectedCategory;
  final double height;
  final double paddingVertical;
  final double paddingHorizontal;

  final ValueChanged<Category?> onCategorySelected;

  const CategoryChipsHeaderDelegate({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.height,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
  });

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

    return Container(
      color: theme.scaffoldBackgroundColor,
      height: height,
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        separatorBuilder: (context, index) {
          return const SizedBox(width: _chipSeparatorWidth);
        },
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return FilterChip(
              label: Text(l10n.productCatalogAllCategory),
              onSelected: (_) => onCategorySelected(null),
              showCheckmark: false,
              selected: selectedCategory == null,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            );
          }

          final category = categories[index - 1];
          return FilterChip(
            label: Row(
              spacing: 4,
              children: [Text(category.emoji), Text(category.label)],
            ),
            onSelected: (_) => onCategorySelected(category),
            showCheckmark: false,
            selected: selectedCategory?.id == category.id,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant CategoryChipsHeaderDelegate oldDelegate) {
    return oldDelegate.selectedCategory != selectedCategory;
  }
}
