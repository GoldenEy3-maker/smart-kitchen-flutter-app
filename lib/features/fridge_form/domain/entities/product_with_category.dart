import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

class ProductWithCategory extends Equatable {
  const ProductWithCategory({
    required this.product,
    required this.category,
  });

  ProductWithCategory.loading()
    : this(
        product: Product.loading(),
        category: Category.loading(),
      );

  final Product product;
  final Category category;

  @override
  List<Object> get props => [product, category];
}
