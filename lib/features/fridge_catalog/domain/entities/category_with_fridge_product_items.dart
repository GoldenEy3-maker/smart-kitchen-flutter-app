import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";

import "fridge_product_item.dart";

class CategoryWithFridgeProductItems extends Equatable {
  const CategoryWithFridgeProductItems({
    required this.category,
    required this.fridgeProducts,
  });

  final Category category;
  final List<FridgeProductItem> fridgeProducts;

  static List<CategoryWithFridgeProductItems> groupByCategories(
    List<Category> categories,
    List<FridgeProductItem> fridgeProducts,
  ) {
    return categories
        .map(
          (category) => CategoryWithFridgeProductItems(
            category: category,
            fridgeProducts: fridgeProducts
                .where(
                  (fridgeProduct) =>
                      fridgeProduct.product.categoryId == category.id,
                )
                .toList(),
          ),
        )
        .where((category) => category.fridgeProducts.isNotEmpty)
        .toList();
  }

  static CategoryWithFridgeProductItems get loading =>
      CategoryWithFridgeProductItems(
        category: Category.loading,
        fridgeProducts: [
          FridgeProductItem.loading,
          FridgeProductItem.loading,
          FridgeProductItem.loading,
        ],
      );

  @override
  List<Object?> get props => [category, fridgeProducts];
}
