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
