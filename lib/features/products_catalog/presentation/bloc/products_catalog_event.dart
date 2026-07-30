part of "products_catalog_bloc.dart";

sealed class ProductsCatalogEvent extends Equatable {
  const ProductsCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsCatalogRequested extends ProductsCatalogEvent {
  const LoadProductsCatalogRequested();
}

class SelectedCategoryChanged extends ProductsCatalogEvent {
  final Category? category;
  const SelectedCategoryChanged({required this.category});

  @override
  List<Object?> get props => [...super.props, category];
}

class SearchQueryChanged extends ProductsCatalogEvent {
  final String query;
  const SearchQueryChanged({required this.query});

  @override
  List<Object?> get props => [...super.props, query];
}

class ProductDeleted extends ProductsCatalogEvent {
  const ProductDeleted({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductCreated extends ProductsCatalogEvent {
  const ProductCreated({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductUpdated extends ProductsCatalogEvent {
  const ProductUpdated({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductCategoriesUpdated extends ProductsCatalogEvent {
  const ProductCategoriesUpdated({required this.categories});

  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, categories];
}
