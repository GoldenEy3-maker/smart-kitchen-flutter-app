part of "fridge_form_bloc.dart";

class FridgeFormState extends Equatable {
  const FridgeFormState({
    required this.products,
    this.selectedProduct,
    this.selectedQuantity = 1,
    this.selectedExpirationDate,
    this.isProductsLoading = false,
    this.error,
  });

  final List<ProductWithCategory> products;
  final ProductWithCategory? selectedProduct;
  final int selectedQuantity;
  final DateTime? selectedExpirationDate;
  final bool isProductsLoading;
  final Failure? error;

  FridgeFormState copyWith({
    List<ProductWithCategory>? products,
    ValueGetter<ProductWithCategory?>? selectedProduct,
    int? selectedQuantity,
    ValueGetter<DateTime?>? selectedExpirationDate,
    bool? isProductsLoading,
    ValueGetter<Failure?>? error,
  }) {
    return FridgeFormState(
      products: products ?? this.products,
      selectedProduct: selectedProduct != null
          ? selectedProduct()
          : this.selectedProduct,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
      selectedExpirationDate: selectedExpirationDate != null
          ? selectedExpirationDate()
          : this.selectedExpirationDate,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
    products,
    selectedProduct,
    selectedQuantity,
    selectedExpirationDate,
    isProductsLoading,
    error,
  ];
}
