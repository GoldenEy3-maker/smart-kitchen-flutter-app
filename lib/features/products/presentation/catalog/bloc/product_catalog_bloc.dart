import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";

part "product_catalog_event.dart";
part "product_catalog_state.dart";

class ProductCatalogBloc
    extends Bloc<ProductCatalogEvent, ProductCatalogState> {
  final GetCategories _getCategories;
  final GetProducts _getProducts;

  ProductCatalogBloc({required this._getCategories, required this._getProducts})
    : super(
        const ProductCatalogState(
          categories: [],
          products: [],
          isLoading: false,
          error: null,
          selectedCategory: null,
          searchQuery: "",
        ),
      ) {
    on<LoadProductCatalogRequested>(_onLoadProductCatalogRequested);
    on<SelectedCategoryChanged>(_onSelectedCategoryChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onLoadProductCatalogRequested(
    LoadProductCatalogRequested event,
    Emitter<ProductCatalogState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final (categoriesResult, productsResult) = await (
      _getCategories(NoParams()),
      _getProducts(NoParams()),
    ).wait;
    categoriesResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (categories) =>
          emit(state.copyWith(isLoading: false, categories: categories)),
    );
    productsResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
    );
  }

  void _onSelectedCategoryChanged(
    SelectedCategoryChanged event,
    Emitter<ProductCatalogState> emit,
  ) {
    emit(state.copyWith(selectedCategory: () => event.category));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ProductCatalogState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
