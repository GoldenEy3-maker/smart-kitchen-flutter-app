import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";

import "product.dart";

class CategoryProduct extends Equatable {
  final Category category;
  final List<Product> products;

  const CategoryProduct({required this.category, required this.products});

  static List<CategoryProduct> groupByCategories(
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
        .where((categoryProduct) => categoryProduct.products.isNotEmpty)
        .toList();
  }

  static CategoryProduct get loading => CategoryProduct(
    category: Category.loading,
    products: [Product.loading, Product.loading, Product.loading],
  );

  @override
  List<Object?> get props => [category, products];
}

extension ListCategoryProductExtension on List<CategoryProduct> {
  List<Category> toCategories() =>
      map((categoryProduct) => categoryProduct.category).toList();
}
