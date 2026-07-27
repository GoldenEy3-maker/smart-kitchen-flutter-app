part of "product_form_bloc.dart";

class ProductFormState extends Equatable {
  const ProductFormState({
    required this.categories,
    this.selectedCategory,
    this.isLoading = false,
    this.isCreateCategoryPending = false,
    this.isDeleteCategoryPending = false,
    this.isEditCategoryPending = false,
    this.error,
  });

  final List<CategoryWithProductsCount> categories;
  final CategoryWithProductsCount? selectedCategory;
  final bool isLoading;
  final bool isCreateCategoryPending;
  final bool isDeleteCategoryPending;
  final bool isEditCategoryPending;
  final Failure? error;

  ProductFormState copyWith({
    List<CategoryWithProductsCount>? categories,
    ValueGetter<CategoryWithProductsCount?>? selectedCategory,
    bool? isLoading,
    bool? isCreateCategoryPending,
    bool? isDeleteCategoryPending,
    bool? isEditCategoryPending,
    ValueGetter<Failure?>? error,
  }) {
    return ProductFormState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory != null
          ? selectedCategory()
          : this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      isCreateCategoryPending:
          isCreateCategoryPending ?? this.isCreateCategoryPending,
      isDeleteCategoryPending:
          isDeleteCategoryPending ?? this.isDeleteCategoryPending,
      isEditCategoryPending:
          isEditCategoryPending ?? this.isEditCategoryPending,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    selectedCategory,
    isLoading,
    isCreateCategoryPending,
    isDeleteCategoryPending,
    error,
  ];
}
