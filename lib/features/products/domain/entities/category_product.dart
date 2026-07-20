import "package:equatable/equatable.dart";

import "category.dart";
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
