part of "product_catalog_bloc.dart";

sealed class ProductCatalogEvent extends Equatable {
  const ProductCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductCatalogRequested extends ProductCatalogEvent {
  const LoadProductCatalogRequested();
}

class SelectedCategoryChanged extends ProductCatalogEvent {
  final Category? category;
  const SelectedCategoryChanged({required this.category});

  @override
  List<Object?> get props => [...super.props, category];
}

class SearchQueryChanged extends ProductCatalogEvent {
  final String query;
  const SearchQueryChanged({required this.query});

  @override
  List<Object?> get props => [...super.props, query];
}

class ProductDeleted extends ProductCatalogEvent {
  const ProductDeleted({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductCreated extends ProductCatalogEvent {
  const ProductCreated({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductUpdated extends ProductCatalogEvent {
  const ProductUpdated({required this.product, required this.categories});

  final Product product;
  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, product, categories];
}

class ProductCategoriesUpdated extends ProductCatalogEvent {
  const ProductCategoriesUpdated({required this.categories});

  final List<Category> categories;

  @override
  List<Object?> get props => [...super.props, categories];
}
