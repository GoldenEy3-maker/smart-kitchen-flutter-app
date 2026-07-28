part of "product_form_bloc.dart";

class ProductFormState extends Equatable {
  const ProductFormState({
    required this.categories,
    this.selectedCategory,
    this.isCategoriesLoading = false,
    this.isCreateCategoryPending = false,
    this.isDeleteCategoryPending = false,
    this.isEditCategoryPending = false,
    this.selectedCatalogIcon,
    this.selectedCatalogUnit,
    this.error,
  });

  final List<CategoryWithProductsCount> categories;
  final CategoryWithProductsCount? selectedCategory;
  final bool isCategoriesLoading;
  final bool isCreateCategoryPending;
  final bool isDeleteCategoryPending;
  final bool isEditCategoryPending;
  final CatalogIcons? selectedCatalogIcon;
  final CatalogUnits? selectedCatalogUnit;
  final Failure? error;

  ProductFormState copyWith({
    List<CategoryWithProductsCount>? categories,
    ValueGetter<CategoryWithProductsCount?>? selectedCategory,
    bool? isCategoriesLoading,
    bool? isCreateCategoryPending,
    bool? isDeleteCategoryPending,
    bool? isEditCategoryPending,
    CatalogIcons? selectedCatalogIcon,
    CatalogUnits? selectedCatalogUnit,
    ValueGetter<Failure?>? error,
  }) {
    return ProductFormState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory != null
          ? selectedCategory()
          : this.selectedCategory,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isCreateCategoryPending:
          isCreateCategoryPending ?? this.isCreateCategoryPending,
      isDeleteCategoryPending:
          isDeleteCategoryPending ?? this.isDeleteCategoryPending,
      isEditCategoryPending:
          isEditCategoryPending ?? this.isEditCategoryPending,
      selectedCatalogIcon: selectedCatalogIcon ?? this.selectedCatalogIcon,
      selectedCatalogUnit: selectedCatalogUnit ?? this.selectedCatalogUnit,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    selectedCategory,
    isCategoriesLoading,
    isCreateCategoryPending,
    isDeleteCategoryPending,
    isEditCategoryPending,
    selectedCatalogIcon,
    selectedCatalogUnit,
    error,
  ];
}
