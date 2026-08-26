import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

class CategoryWithProducts extends Equatable {
  const CategoryWithProducts({required this.category, required this.products});

  CategoryWithProducts.loading()
    : this(
        category: Category.loading(),
        products: [Product.loading(), Product.loading(), Product.loading()],
      );

  final Category category;
  final List<Product> products;

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

  @override
  List<Object?> get props => [category, products];
}

extension ListCategoryWithProductsExtension on List<CategoryWithProducts> {
  List<Category> toCategories() =>
      map((categoryProduct) => categoryProduct.category).toList();
}
