import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
}

class Category {
  final String id;
  final String label;
  final String emoji;

  Category({required this.id, required this.label, required this.emoji});
}

final List<Category> categories = [
  Category(id: "vegetables", label: "Овощи", emoji: "🥬"),
  Category(id: "fruits", label: "Фрукты", emoji: "🍎"),
  Category(id: "meat", label: "Мясо", emoji: "🍖"),
  Category(id: "fish", label: "Рыба", emoji: "🍣"),
  Category(id: "dairy", label: "Молоко", emoji: "🥛"),
  Category(id: "bread", label: "Хлеб", emoji: "🍞"),
  Category(id: "alcohol", label: "Алкоголь", emoji: "🍺"),
  Category(id: "other", label: "Другие", emoji: "🍽"),
];

class Product {
  final String id;
  final String name;
  final String emoji;
  final String unit;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.emoji,
    required this.unit,
    required this.categoryId,
  });
}

final List<Product> products = [
  Product(
    id: "1",
    name: "Картофель",
    emoji: "🥦",
    unit: "кг",
    categoryId: "vegetables",
  ),
  Product(
    id: "2",
    name: "Яблоко",
    emoji: "🍎",
    unit: "шт",
    categoryId: "fruits",
  ),
  Product(
    id: "3",
    name: "Говядина",
    emoji: "🍖",
    unit: "кг",
    categoryId: "meat",
  ),
  Product(id: "4", name: "Лосось", emoji: "🍣", unit: "шт", categoryId: "fish"),
  Product(id: "5", name: "Молоко", emoji: "🥛", unit: "л", categoryId: "dairy"),
  Product(id: "6", name: "Хлеб", emoji: "🍞", unit: "шт", categoryId: "bread"),
  Product(id: "7", name: "Пиво", emoji: "🍺", unit: "л", categoryId: "alcohol"),
  Product(id: "8", name: "Салат", emoji: "🍽", unit: "шт", categoryId: "other"),
  Product(id: "9", name: "Творог", emoji: "🥛", unit: "г", categoryId: "dairy"),
  Product(
    id: "10",
    name: "Спагетти",
    emoji: "🍝",
    unit: "г",
    categoryId: "bread",
  ),
  Product(
    id: "11",
    name: "Вино",
    emoji: "🍷",
    unit: "л",
    categoryId: "alcohol",
  ),
  Product(
    id: "12",
    name: "Гамбургер",
    emoji: "🍔",
    unit: "шт",
    categoryId: "other",
  ),
  Product(id: "13", name: "Сыр", emoji: "🥛", unit: "г", categoryId: "dairy"),
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
  static const double searchBarHeight = 56 + containerVerticalGap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: CustomScrollView(
        physics: const NoImplicitScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: containerHorizontalPadding,
              ),
              child: Text(
                l10n.productCatalogTotalWithDescription(
                  totalProducts.toString(),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPersistentHeader(
            floating: true,
            delegate: _SearchHeaderDelegate(),
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
        ],
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _SearchHeaderDelegate();

  @override
  double get minExtent => _ProductCatalogViewState.searchBarHeight;

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
      height: _ProductCatalogViewState.searchBarHeight,
      padding: const EdgeInsets.only(
        top: _ProductCatalogViewState.containerVerticalGap,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _ProductCatalogViewState.containerHorizontalPadding,
        ),
        child: TextField(
          scrollPadding: EdgeInsets.zero,
          decoration: InputDecoration(
            hintText: l10n.productCatalogSearchHint,
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(Icons.search),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) {
    return false;
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
                    color: Colors.brown.shade100,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Center(child: Text(product.emoji)),
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
