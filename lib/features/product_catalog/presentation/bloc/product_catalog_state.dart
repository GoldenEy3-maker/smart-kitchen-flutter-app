part of "product_catalog_bloc.dart";

class ProductCatalogState extends Equatable {
  final List<Category> categories;
  final List<Product> products;
  final Category? selectedCategory;
  final String searchQuery;
  final bool isLoading;
  final Failure? error;

  const ProductCatalogState({
    required this.categories,
    required this.products,
    required this.selectedCategory,
    required this.searchQuery,
    required this.isLoading,
    required this.error,
  });

  ProductCatalogState copyWith({
    List<Category>? categories,
    List<Product>? products,
    ValueGetter<Category?>? selectedCategory,
    String? searchQuery,
    bool? isLoading,
    Failure? error,
  }) {
    return ProductCatalogState(
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
    final query = searchQuery.toLowerCase();
    return products
        .where(
          (product) =>
              (selectedCategory == null ||
                  product.categoryId == selectedCategory?.id) &&
              product.name.toLowerCase().contains(query),
        )
        .toList();
  }

  List<CategoryProduct> get categoryProducts =>
      CategoryProduct.groupByCategories(categories, filteredProducts);
}
