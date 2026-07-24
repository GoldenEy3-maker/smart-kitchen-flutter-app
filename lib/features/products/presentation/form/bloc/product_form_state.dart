part of "product_form_bloc.dart";

class ProductFormState extends Equatable {
  const ProductFormState({
    required this.categories,
    this.selectedCategory,
    this.isLoading = false,
    this.isCreateCategoryPending = false,
    this.error,
  });

  final List<CategoryWithProductsCount> categories;
  final CategoryWithProductsCount? selectedCategory;
  final bool isLoading;
  final bool isCreateCategoryPending;
  final Failure? error;

  ProductFormState copyWith({
    List<CategoryWithProductsCount>? categories,
    CategoryWithProductsCount? selectedCategory,
    bool? isLoading,
    bool? isCreateCategoryPending,
    Failure? error,
    bool clearError = false,
  }) {
    return ProductFormState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      isCreateCategoryPending:
          isCreateCategoryPending ?? this.isCreateCategoryPending,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [
    categories,
    selectedCategory,
    isLoading,
    isCreateCategoryPending,
    error,
  ];
}
