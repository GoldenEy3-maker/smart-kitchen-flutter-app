import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/usecases/usecases.dart";

part "fridge_catalog_event.dart";
part "fridge_catalog_state.dart";

class FridgeCatalogBloc extends Bloc<FridgeCatalogEvent, FridgeCatalogState> {
  FridgeCatalogBloc({
    required this._getCategories,
    required this._getFridgeCatalogItems,
  }) : super(const FridgeCatalogState()) {
    on<LoadFridgeCatalogRequested>(_onLoadFridgeCatalogRequested);
    on<SelectedCategoryChanged>(_onSelectedCategoryChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  final GetCategories _getCategories;
  final GetFridgeCatalogItems _getFridgeCatalogItems;

  void _onLoadFridgeCatalogRequested(
    LoadFridgeCatalogRequested event,
    Emitter<FridgeCatalogState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: () => null));
    final (categoriesResult, fridgeCatalogItemsResult) = await (
      _getCategories(NoParams()),
      _getFridgeCatalogItems(NoParams()),
    ).wait;

    categoriesResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: () => failure)),
      (categories) =>
          emit(state.copyWith(isLoading: false, categories: categories)),
    );

    fridgeCatalogItemsResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: () => failure)),
      (fridgeProducts) => emit(
        state.copyWith(isLoading: false, fridgeProducts: fridgeProducts),
      ),
    );
  }

  void _onSelectedCategoryChanged(
    SelectedCategoryChanged event,
    Emitter<FridgeCatalogState> emit,
  ) {
    emit(state.copyWith(selectedCategory: () => event.category));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<FridgeCatalogState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
