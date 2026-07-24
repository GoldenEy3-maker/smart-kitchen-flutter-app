import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

part "product_form_event.dart";
part "product_form_state.dart";

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc({
    required this._getCategoriesWithProductsCount,
    required this._createCategory,
  }) : super(
         ProductFormState(
           categories: [],
           error: null,
           isLoading: false,
           isCreateCategoryPending: false,
           selectedCategory: null,
         ),
       ) {
    on<ProductFormCategoriesRequested>(_onCategoriesRequested);
    on<ProductFormCategorySelected>(_onCategorySelected);
    on<ProductFormCategoryCreateRequested>(_onCategoryCreateRequested);
  }

  final GetCategoriesWithProductsCount _getCategoriesWithProductsCount;
  final CreateCategory _createCategory;

  Future<void> _onCategoriesRequested(
    ProductFormCategoriesRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getCategoriesWithProductsCount(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure)),
      (categories) {
        emit(state.copyWith(isLoading: false, categories: categories));

        if (event.product != null) {
          final selectedCategory = categories.firstWhere(
            (category) => category.id == event.product?.categoryId,
          );

          emit(state.copyWith(selectedCategory: selectedCategory));
        }
      },
    );
  }

  void _onCategorySelected(
    ProductFormCategorySelected event,
    Emitter<ProductFormState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  Future<void> _onCategoryCreateRequested(
    ProductFormCategoryCreateRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isCreateCategoryPending: true, clearError: true));

    final result = await _createCategory(
      CreateCategoryParams(label: event.label, iconKey: event.iconKey),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isCreateCategoryPending: false, error: failure)),
      (category) {
        final newCategoryWithProductsCount = CategoryWithProductsCount(
          id: category.id,
          label: category.label,
          iconKey: category.iconKey,
          productsCount: 0,
        );
        final newCategories = [
          ...state.categories,
          newCategoryWithProductsCount,
        ];

        emit(
          state.copyWith(
            isCreateCategoryPending: false,
            selectedCategory: newCategoryWithProductsCount,
            categories: newCategories,
            clearError: true,
          ),
        );
      },
    );
  }
}
