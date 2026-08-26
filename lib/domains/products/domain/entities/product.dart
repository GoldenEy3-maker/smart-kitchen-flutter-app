import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.unit,
    required this.categoryId,
  });

  Product.loading()
    : this(
        id: "loading",
        name: "Loading Name",
        iconKey: CatalogIcons.fallback.name,
        unit: "",
        categoryId: "loading",
      );

  final String id;
  final String name;
  final String iconKey;
  final String unit;
  final String categoryId;

  @override
  List<Object?> get props => [id, name, iconKey, unit, categoryId];
}
