part of "fridge_catalog_bloc.dart";

class FridgeCatalogState extends Equatable {
  const FridgeCatalogState({
    this.categories = const [],
    this.fridgeProducts = const [],
    this.isLoading = false,
    this.error,
    this.selectedCategory,
    this.searchQuery = "",
  });

  final List<Category> categories;
  final List<FridgeProductItem> fridgeProducts;
  final bool isLoading;
  final Failure? error;
  final Category? selectedCategory;
  final String searchQuery;

  FridgeCatalogState copyWith({
    List<Category>? categories,
    List<FridgeProductItem>? fridgeProducts,
    bool? isLoading,
    ValueGetter<Failure?>? error,
    ValueGetter<Category?>? selectedCategory,
    String? searchQuery,
  }) => FridgeCatalogState(
    categories: categories ?? this.categories,
    fridgeProducts: fridgeProducts ?? this.fridgeProducts,
    isLoading: isLoading ?? this.isLoading,
    error: error != null ? error() : this.error,
    selectedCategory: selectedCategory != null
        ? selectedCategory()
        : this.selectedCategory,
    searchQuery: searchQuery ?? this.searchQuery,
  );

  List<FridgeProductItem> get filteredFridgeProducts {
    final query = searchQuery.toLowerCase().trim();
    return fridgeProducts.where((fridgeProduct) {
      final isCategoryMatch =
          selectedCategory == null ||
          fridgeProduct.product.categoryId == selectedCategory?.id;
      final isProductNameMatch = fridgeProduct.product.name
          .toLowerCase()
          .contains(query);

      return isCategoryMatch && isProductNameMatch;
    }).toList();
  }

  List<CategoryWithFridgeProductItems> get categoriesWithFridgeProducts =>
      CategoryWithFridgeProductItems.groupByCategories(
        categories,
        fridgeProducts,
      );

  List<CategoryWithFridgeProductItems>
  get filteredCategoriesWithFridgeProducts =>
      CategoryWithFridgeProductItems.groupByCategories(
        categories,
        filteredFridgeProducts,
      );

  @override
  List<Object?> get props => [
    categories,
    fridgeProducts,
    isLoading,
    error,
    selectedCategory,
    searchQuery,
  ];
}

extension ListCategoryWithFridgeProductItemsX
    on List<CategoryWithFridgeProductItems> {
  List<Category> toCategories() => map(
    (categoryWithFridgeProductItems) => categoryWithFridgeProductItems.category,
  ).toList();
}
