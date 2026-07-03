import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/widgets/widgets.dart";

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
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

class _ProductCatalogViewState extends State<ProductCatalogView> {
  Category? selectedCategory;
  List<CategoryProduct> categoryProducts = CategoryProduct.groupByCategories(
    categories,
    products,
  );

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
            delegate: SearchHeaderDelegate(
              height: searchBarHeight,
              paddingTop: containerVerticalGap,
              paddingHorizontal: containerHorizontalPadding,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: CategoryChipsHeaderDelegate(
              height: categoryChipsHeight,
              paddingVertical: containerVerticalGap,
              paddingHorizontal: containerHorizontalPadding,
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
                  return ProductTile(
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
