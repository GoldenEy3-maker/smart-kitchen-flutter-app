import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/products_catalog/domain/entities/entities.dart";

part "products_catalog_event.dart";
part "products_catalog_state.dart";

class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  ProductsCatalogBloc({
    required this._getCategories,
    required this._getProducts,
  }) : super(
         const ProductsCatalogState(
           categories: [],
           products: [],
           isLoading: true,
           error: null,
           selectedCategory: null,
           searchQuery: "",
         ),
       ) {
    on<LoadProductsCatalogRequested>(_onLoadProductsCatalogRequested);
    on<SelectedCategoryChanged>(_onSelectedCategoryChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ProductDeleted>(_onProductDeleted);
    on<ProductCreated>(_onProductCreated);
    on<ProductUpdated>(_onProductUpdated);
    on<ProductCategoriesUpdated>(_onProductCategoriesUpdated);
  }
  final GetCategories _getCategories;
  final GetProducts _getProducts;

  Future<void> _onLoadProductsCatalogRequested(
    LoadProductsCatalogRequested event,
    Emitter<ProductsCatalogState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final (categoriesResult, productsResult) = await (
      _getCategories(const NoParams()),
      _getProducts(const NoParams()),
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
    Emitter<ProductsCatalogState> emit,
  ) {
    emit(state.copyWith(selectedCategory: () => event.category));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ProductsCatalogState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductsCatalogState> emit,
  ) {
    emit(
      state.copyWith(
        products: state.products
            .where((product) => product.id != event.product.id)
            .toList(),
      ),
    );
    _syncCategories(event.categories, emit);
  }

  void _onProductCreated(
    ProductCreated event,
    Emitter<ProductsCatalogState> emit,
  ) {
    emit(state.copyWith(products: [event.product, ...state.products]));
    _syncCategories(event.categories, emit);
  }

  void _onProductUpdated(
    ProductUpdated event,
    Emitter<ProductsCatalogState> emit,
  ) {
    emit(
      state.copyWith(
        products: state.products
            .map(
              (product) =>
                  product.id == event.product.id ? event.product : product,
            )
            .toList(),
      ),
    );
    _syncCategories(event.categories, emit);
  }

  void _onProductCategoriesUpdated(
    ProductCategoriesUpdated event,
    Emitter<ProductsCatalogState> emit,
  ) {
    _syncCategories(event.categories, emit);
  }

  void _syncCategories(
    List<Category> categories,
    Emitter<ProductsCatalogState> emit,
  ) {
    final hasSelectedCategory =
        state.selectedCategory != null &&
        (categories.any(
              (category) => category.id == state.selectedCategory?.id,
            ) &&
            state.filteredCategoryWithProducts.any(
              (categoryWithProducts) =>
                  categoryWithProducts.category.id ==
                  state.selectedCategory?.id,
            ));
    emit(
      state.copyWith(
        categories: categories,
        selectedCategory: hasSelectedCategory ? null : () => null,
      ),
    );
  }
}
