import "package:equatable/equatable.dart";

class CategoryWithProductsCount extends Equatable {
  const CategoryWithProductsCount({
    required this.id,
    required this.label,
    required this.iconKey,
    required this.productsCount,
  });

  final String id;
  final String label;
  final String iconKey;
  final int productsCount;

  @override
  List<Object?> get props => [id, label, iconKey, productsCount];
}
