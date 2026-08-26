part of "fridge_form_bloc.dart";

class FridgeFormState extends Equatable {
  const FridgeFormState({
    required this.selectedExpirationDate,
    this.selectedProduct,
    this.selectedQuantity = 0,
  });

  final Product? selectedProduct;
  final int selectedQuantity;
  final DateTime selectedExpirationDate;

  @override
  List<Object?> get props => [
    selectedProduct,
    selectedQuantity,
    selectedExpirationDate,
  ];
}
