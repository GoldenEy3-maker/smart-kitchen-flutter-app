import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/products/domain/entities/entities.dart";

class CategoryWithProducts extends Equatable {
  final Category category;
  final List<Product> products;

  const CategoryWithProducts({required this.category, required this.products});

  static List<CategoryWithProducts> groupByCategories(
    List<Category> categories,
    List<Product> products,
  ) {
    return categories
        .map(
          (category) => CategoryWithProducts(
            category: category,
            products: products
                .where((product) => product.categoryId == category.id)
                .toList(),
          ),
        )
        .where((categoryProduct) => categoryProduct.products.isNotEmpty)
        .toList();
  }

  static CategoryWithProducts get loading => CategoryWithProducts(
    category: Category.loading,
    products: [Product.loading, Product.loading, Product.loading],
  );

  @override
  List<Object?> get props => [category, products];
}

extension ListCategoryWithProductsExtension on List<CategoryWithProducts> {
  List<Category> toCategories() =>
      map((categoryProduct) => categoryProduct.category).toList();
}
