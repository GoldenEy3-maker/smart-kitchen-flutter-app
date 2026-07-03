import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
}

class Category {
  final String id;
  final String label;

  Category({required this.id, required this.label});
}

final List<Category> categories = [
  Category(id: "vegetables", label: "🥬 Овощи"),
  Category(id: "fruits", label: "🍎 Фрукты"),
  Category(id: "meat", label: "🍖 Мясо"),
  Category(id: "fish", label: "🍣 Рыба"),
  Category(id: "dairy", label: "🥛 Молоко"),
  Category(id: "bread", label: "🍞 Хлеб"),
  Category(id: "alcohol", label: "🍺 Алкоголь"),
  Category(id: "other", label: "🍽 Другие"),
];

class Product {
  final String id;
  final String name;
  final String unit;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.categoryId,
  });
}

final List<Product> products = [
  Product(id: "1", name: "🥦 Картофель", unit: "кг", categoryId: "vegetables"),
  Product(id: "2", name: "🍎 Яблоко", unit: "шт", categoryId: "fruits"),
  Product(id: "3", name: "🍖 Говядина", unit: "кг", categoryId: "meat"),
  Product(id: "4", name: "🍣 Лосось", unit: "шт", categoryId: "fish"),
  Product(id: "5", name: "🥛 Молоко", unit: "л", categoryId: "dairy"),
  Product(id: "6", name: "🍞 Хлеб", unit: "шт", categoryId: "bread"),
  Product(id: "7", name: "🍺 Пиво", unit: "л", categoryId: "alcohol"),
  Product(id: "8", name: "🍽 Салат", unit: "шт", categoryId: "other"),
  Product(id: "9", name: "🥛 Творог", unit: "г", categoryId: "dairy"),
  Product(id: "10", name: "🍝 Спагетти", unit: "г", categoryId: "bread"),
  Product(id: "11", name: "🍷 Вино", unit: "л", categoryId: "alcohol"),
  Product(id: "12", name: "🍔 Гамбургер", unit: "шт", categoryId: "other"),
  Product(id: "13", name: "🥛 Сыр", unit: "г", categoryId: "dairy"),
];

class CategoryProduct {
  final Category category;
  final List<Product> products;

  CategoryProduct({required this.category, required this.products});
}

List<CategoryProduct> mapCategoriesAndProductsToCategoryProducts(
  List<Category> categories,
  List<Product> products,
) {
  return categories
      .map(
        (category) => CategoryProduct(
          category: category,
          products: products
              .where((product) => product.categoryId == category.id)
              .toList(),
        ),
      )
      .toList();
}

class _ProductCatalogViewState extends State<ProductCatalogView> {
  Category? selectedCategory;
  List<CategoryProduct> categoryProducts =
      mapCategoriesAndProductsToCategoryProducts(categories, products);

  static const int totalProducts = 48;
  static const double containerVerticalGap = 14;
  static const double containerHorizontalPadding = 20;
  static const double categoryChipsHeight = 36 + containerVerticalGap * 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: containerHorizontalPadding,
            ),
            margin: const EdgeInsets.only(bottom: containerVerticalGap),
            child: Text(
              l10n.productCatalogTotalWithDescription(totalProducts.toString()),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: containerHorizontalPadding,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.productCatalogSearchHint,
                prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
              ),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _CategoryChipsHeaderDelegate(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
        ),
        for (var i = 0; i < categoryProducts.length; i++) ...[
          if (i > 0)
            const SliverToBoxAdapter(
              child: SizedBox(height: containerVerticalGap),
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: containerHorizontalPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(categoryProducts[i].category.label),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: containerVerticalGap),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: containerHorizontalPadding,
            ),
            sliver: SliverList.separated(
              itemCount: categoryProducts[i].products.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: containerVerticalGap);
              },
              itemBuilder: (context, index) {
                return _ProductTile(
                  product: categoryProducts[i].products[index],
                );
              },
            ),
          ),
        ],
        SliverSafeArea(sliver: SliverToBoxAdapter(child: SizedBox.shrink())),
      ],
    );
  }
}

class _CategoryChipsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _CategoryChipsHeaderDelegate({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<Category> categories;
  final Category? selectedCategory;

  final ValueChanged<Category?> onCategorySelected;

  static const double _chipSeparatorWidth = 10;

  @override
  double get minExtent => _ProductCatalogViewState.categoryChipsHeight;

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
      height: _ProductCatalogViewState.categoryChipsHeight,
      padding: const EdgeInsets.symmetric(
        vertical: _ProductCatalogViewState.containerVerticalGap,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: _ProductCatalogViewState.containerHorizontalPadding,
        ),
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
            label: Text(category.label),
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
  bool shouldRebuild(covariant _CategoryChipsHeaderDelegate oldDelegate) {
    return oldDelegate.selectedCategory != selectedCategory;
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;

  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name),
                    Text(l10n.productCatalogProductUnit(product.unit)),
                  ],
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.chevron_right)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
