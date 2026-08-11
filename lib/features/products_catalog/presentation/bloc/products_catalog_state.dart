part of "products_catalog_bloc.dart";

class ProductsCatalogState extends Equatable {
  const ProductsCatalogState({
    required this.categories,
    required this.products,
    required this.selectedCategory,
    required this.searchQuery,
    required this.isLoading,
    required this.error,
  });

  final List<Category> categories;
  final List<Product> products;
  final Category? selectedCategory;
  final String searchQuery;
  final bool isLoading;
  final Failure? error;

  ProductsCatalogState copyWith({
    List<Category>? categories,
    List<Product>? products,
    ValueGetter<Category?>? selectedCategory,
    String? searchQuery,
    bool? isLoading,
    Failure? error,
  }) {
    return ProductsCatalogState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategory: selectedCategory != null
          ? selectedCategory()
          : this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    products,
    selectedCategory,
    searchQuery,
    isLoading,
    error,
  ];

  List<Product> get filteredProducts {
    final query = searchQuery.toLowerCase().trim();
    return products.where((product) {
      final isCategoryMatch =
          selectedCategory == null ||
          product.categoryId == selectedCategory?.id;
      final isProductNameMatch = product.name.toLowerCase().contains(query);

      return isCategoryMatch && isProductNameMatch;
    }).toList();
  }

  List<CategoryWithProducts> get filteredCategoryWithProducts =>
      CategoryWithProducts.groupByCategories(categories, filteredProducts);

  List<CategoryWithProducts> get categoryWithProducts =>
      CategoryWithProducts.groupByCategories(categories, products);
}
