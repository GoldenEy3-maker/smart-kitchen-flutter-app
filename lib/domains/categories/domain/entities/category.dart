import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";

class Category extends Equatable {
  const Category({
    required this.id,
    required this.label,
    required this.iconKey,
  });

  Category.loading()
    : this(
        id: "loading",
        label: "Loading",
        iconKey: CatalogIcons.fallback.name,
      );

  final String id;
  final String label;
  final String iconKey;

  @override
  List<Object?> get props => [id, label, iconKey];
}
