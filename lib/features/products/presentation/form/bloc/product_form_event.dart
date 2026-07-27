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
