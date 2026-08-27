import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/usecases/usecases.dart";

part "fridge_form_event.dart";
part "fridge_form_state.dart";

class FridgeFormBloc extends Bloc<FridgeFormEvent, FridgeFormState> {
  FridgeFormBloc({required this._getProductsWithCategories})
    : super(const FridgeFormState(products: [])) {
    on<FridgeFormProductsRequested>(_onProductsRequested);
    on<FridgeFormProductSelected>(_onProductSelected);
    on<FridgeFormQuantityChanged>(_onQuantityChanged);
    on<FridgeFormExpirationDateChanged>(_onExpirationDateChanged);
    on<FridgeFormProductCreated>(_onProductCreated);
  }

  final GetProductsWithCategories _getProductsWithCategories;

  Future<void> _onProductsRequested(
    FridgeFormProductsRequested event,
    Emitter<FridgeFormState> emit,
  ) async {
    emit(state.copyWith(isProductsLoading: true, error: () => null));
    final result = await _getProductsWithCategories(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isProductsLoading: false, error: () => failure),
      ),
      (products) => emit(
        state.copyWith(
          isProductsLoading: false,
          products: products,
          error: () => null,
        ),
      ),
    );
  }

  void _onProductSelected(
    FridgeFormProductSelected event,
    Emitter<FridgeFormState> emit,
  ) {
    emit(state.copyWith(selectedProduct: () => event.product));
  }

  void _onQuantityChanged(
    FridgeFormQuantityChanged event,
    Emitter<FridgeFormState> emit,
  ) {
    emit(state.copyWith(selectedQuantity: event.quantity));
  }

  void _onExpirationDateChanged(
    FridgeFormExpirationDateChanged event,
    Emitter<FridgeFormState> emit,
  ) {
    emit(state.copyWith(selectedExpirationDate: () => event.expirationDate));
  }

  void _onProductCreated(
    FridgeFormProductCreated event,
    Emitter<FridgeFormState> emit,
  ) {
    final category = event.categories.firstWhere(
      (category) => category.id == event.product.categoryId,
    );
    final product = ProductWithCategory(
      product: event.product,
      category: category,
    );

    emit(
      state.copyWith(
        products: [product, ...state.products],
        selectedProduct: () => product,
        error: () => null,
      ),
    );
  }
}
