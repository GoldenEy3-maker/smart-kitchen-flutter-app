part of "product_form_bloc.dart";

sealed class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object?> get props => [];
}

class ProductFormCategoriesRequested extends ProductFormEvent {
  const ProductFormCategoriesRequested({this.product});

  final Product? product;

  @override
  List<Object?> get props => [product];
}

class ProductFormCategorySelected extends ProductFormEvent {
  const ProductFormCategorySelected({required this.category});
  final CategoryWithProductsCount category;

  @override
  List<Object> get props => [category];
}

class ProductFormCategoryCreateRequested extends ProductFormEvent {
  const ProductFormCategoryCreateRequested({
    required this.label,
    required this.iconKey,
  });
  final String label;
  final String iconKey;

  @override
  List<Object> get props => [label, iconKey];
}

class ProductFormCategoryDeleteRequested extends ProductFormEvent {
  const ProductFormCategoryDeleteRequested({required this.category});

  final CategoryWithProductsCount category;

  @override
  List<Object> get props => [category];
}

class ProductFormCategoryEditRequested extends ProductFormEvent {
  const ProductFormCategoryEditRequested({required this.category});

  final CategoryWithProductsCount category;

  @override
  List<Object> get props => [category];
}

class ProductFormCatalogIconSelected extends ProductFormEvent {
  const ProductFormCatalogIconSelected({required this.catalogIcon});

  final CatalogIcons catalogIcon;

  @override
  List<Object> get props => [catalogIcon];
}

class ProductFormCatalogUnitSelected extends ProductFormEvent {
  const ProductFormCatalogUnitSelected({required this.catalogUnit});

  final CatalogUnits catalogUnit;

  @override
  List<Object> get props => [catalogUnit];
}

class ProductFormCreateRequested extends ProductFormEvent {
  const ProductFormCreateRequested({required this.params});

  final CreateProductParams params;

  @override
  List<Object> get props => [params];
}

class ProductFormUpdateRequested extends ProductFormEvent {
  const ProductFormUpdateRequested({required this.params});

  final UpdateProductParams params;

  @override
  List<Object> get props => [params];
}

class ProductFormDeleteRequested extends ProductFormEvent {
  const ProductFormDeleteRequested({required this.params});

  final DeleteProductParams params;

  @override
  List<Object> get props => [params];
}
