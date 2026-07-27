import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";

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

  static CategoryWithProductsCount get loading => CategoryWithProductsCount(
    id: "loading",
    label: "Loading Title...",
    iconKey: CatalogIcons.fallback.name,
    productsCount: 0,
  );

  @override
  List<Object?> get props => [id, label, iconKey, productsCount];
}
