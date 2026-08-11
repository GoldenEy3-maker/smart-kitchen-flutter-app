part of "fridge_catalog_bloc.dart";

sealed class FridgeCatalogEvent extends Equatable {
  const FridgeCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadFridgeCatalogRequested extends FridgeCatalogEvent {
  const LoadFridgeCatalogRequested();
}

class SelectedCategoryChanged extends FridgeCatalogEvent {
  const SelectedCategoryChanged({required this.category});

  final Category? category;

  @override
  List<Object?> get props => [...super.props, category];
}

class SearchQueryChanged extends FridgeCatalogEvent {
  const SearchQueryChanged({required this.query});

  final String query;

  @override
  List<Object?> get props => [...super.props, query];
}
