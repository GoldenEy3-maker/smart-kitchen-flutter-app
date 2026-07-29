import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";
import "package:smart_kitchen_flutter_app/core/units/catalog_units.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/products/params/params.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

part "product_form_event.dart";
part "product_form_state.dart";

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc({
    this._product,
    required this._getCategoriesWithProductsCount,
    required this._createCategory,
    required this._deleteCategory,
    required this._updateCategory,
    required this._createProduct,
    required this._updateProduct,
    required this._deleteProduct,
  }) : super(
         ProductFormState(
           categories: [],
           selectedCatalogUnit: _product != null
               ? CatalogUnits.fromName(_product.unit)
               : null,
           selectedCatalogIcon: _product != null
               ? CatalogIcons.fromName(_product.iconKey)
               : null,
         ),
       ) {
    on<ProductFormCategoriesRequested>(_onCategoriesRequested);
    on<ProductFormCategorySelected>(_onCategorySelected);
    on<ProductFormCategoryCreateRequested>(_onCategoryCreateRequested);
    on<ProductFormCategoryDeleteRequested>(_onCategoryDeleteRequested);
    on<ProductFormCategoryEditRequested>(_onCategoryEditRequested);
    on<ProductFormCatalogIconSelected>(_onCatalogIconSelected);
    on<ProductFormCatalogUnitSelected>(_onCatalogUnitSelected);
    on<ProductFormCreateRequested>(_onProductCreateRequested);
    on<ProductFormUpdateRequested>(_onProductUpdateRequested);
    on<ProductFormDeleteRequested>(_onProductDeleteRequested);
  }

  // ignore: unused_field
  final Product? _product;
  final GetCategoriesWithProductsCount _getCategoriesWithProductsCount;
  final CreateCategory _createCategory;
  final DeleteCategory _deleteCategory;
  final UpdateCategory _updateCategory;
  final CreateProduct _createProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  Future<void> _onCategoriesRequested(
    ProductFormCategoriesRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isCategoriesLoading: true, error: () => null));
    final result = await _getCategoriesWithProductsCount(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isCategoriesLoading: false, error: () => failure),
      ),
      (categories) {
        emit(
          state.copyWith(
            isCategoriesLoading: false,
            categories: categories,
            error: () => null,
          ),
        );

        if (event.product != null) {
          final selectedCategory = categories.firstWhere(
            (category) => category.id == event.product?.categoryId,
          );

          emit(state.copyWith(selectedCategory: () => selectedCategory));
        }
      },
    );
  }

  void _onCategorySelected(
    ProductFormCategorySelected event,
    Emitter<ProductFormState> emit,
  ) {
    emit(state.copyWith(selectedCategory: () => event.category));
  }

  Future<void> _onCategoryCreateRequested(
    ProductFormCategoryCreateRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isCreateCategoryPending: true, error: () => null));

    final result = await _createCategory(
      CreateCategoryParams(label: event.label, iconKey: event.iconKey),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isCreateCategoryPending: false, error: () => failure),
      ),
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
            selectedCategory: () => newCategoryWithProductsCount,
            categories: newCategories,
            error: () => null,
          ),
        );
      },
    );
  }

  Future<void> _onCategoryDeleteRequested(
    ProductFormCategoryDeleteRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isDeleteCategoryPending: true, error: () => null));

    final result = await _deleteCategory(
      DeleteCategoryParams(id: event.category.id),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isDeleteCategoryPending: false, error: () => failure),
      ),
      (_) {
        final isSelectedCategory =
            state.selectedCategory?.id == event.category.id;
        final newCategories = state.categories
            .where((category) => category.id != event.category.id)
            .toList();

        emit(
          state.copyWith(
            isDeleteCategoryPending: false,
            error: () => null,
            categories: newCategories,
            selectedCategory: isSelectedCategory ? () => null : null,
          ),
        );
      },
    );
  }

  Future<void> _onCategoryEditRequested(
    ProductFormCategoryEditRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isEditCategoryPending: true, error: () => null));

    final result = await _updateCategory(
      UpdateCategoryParams(
        id: event.category.id,
        label: event.category.label,
        iconKey: event.category.iconKey,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isEditCategoryPending: false, error: () => failure),
      ),
      (updatedCategory) {
        final updatedCategoryWithProductsCount = CategoryWithProductsCount(
          id: updatedCategory.id,
          label: updatedCategory.label,
          iconKey: updatedCategory.iconKey,
          productsCount: event.category.productsCount,
        );

        final newCategories = state.categories.map((category) {
          if (category.id == updatedCategory.id) {
            return updatedCategoryWithProductsCount;
          }
          return category;
        }).toList();
        final isSelectedCategory =
            state.selectedCategory?.id == updatedCategory.id;

        emit(
          state.copyWith(
            isEditCategoryPending: false,
            error: () => null,
            categories: newCategories,
            selectedCategory: isSelectedCategory
                ? () => updatedCategoryWithProductsCount
                : null,
          ),
        );
      },
    );
  }

  void _onCatalogIconSelected(
    ProductFormCatalogIconSelected event,
    Emitter<ProductFormState> emit,
  ) {
    emit(state.copyWith(selectedCatalogIcon: event.catalogIcon));
  }

  void _onCatalogUnitSelected(
    ProductFormCatalogUnitSelected event,
    Emitter<ProductFormState> emit,
  ) {
    emit(state.copyWith(selectedCatalogUnit: event.catalogUnit));
  }

  void _onProductCreateRequested(
    ProductFormCreateRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(
      state.copyWith(
        isSaveProductPending: true,
        error: () => null,
        savedProduct: () => null,
      ),
    );

    final result = await _createProduct(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(isSaveProductPending: false, error: () => failure),
      ),
      (product) => emit(
        state.copyWith(
          isSaveProductPending: false,
          error: () => null,
          savedProduct: () => product,
        ),
      ),
    );
  }

  void _onProductUpdateRequested(
    ProductFormUpdateRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(
      state.copyWith(
        isSaveProductPending: true,
        error: () => null,
        savedProduct: () => null,
      ),
    );

    final result = await _updateProduct(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(isSaveProductPending: false, error: () => failure),
      ),
      (product) => emit(
        state.copyWith(
          isSaveProductPending: false,
          error: () => null,
          savedProduct: () => product,
        ),
      ),
    );
  }

  void _onProductDeleteRequested(
    ProductFormDeleteRequested event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isDeleteProductPending: true, error: () => null));

    final result = await _deleteProduct(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(isDeleteProductPending: false, error: () => failure),
      ),
      (_) => emit(
        state.copyWith(isDeleteProductPending: false, error: () => null),
      ),
    );
  }
}
