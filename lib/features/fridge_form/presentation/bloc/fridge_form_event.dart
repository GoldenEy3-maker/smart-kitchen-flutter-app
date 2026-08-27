part of "fridge_form_bloc.dart";

sealed class FridgeFormEvent extends Equatable {
  const FridgeFormEvent();

  @override
  List<Object?> get props => [];
}

class FridgeFormProductsRequested extends FridgeFormEvent {
  const FridgeFormProductsRequested();
}

class FridgeFormProductSelected extends FridgeFormEvent {
  const FridgeFormProductSelected({required this.product});

  final ProductWithCategory product;

  @override
  List<Object> get props => [product];
}

class FridgeFormQuantityChanged extends FridgeFormEvent {
  const FridgeFormQuantityChanged({required this.quantity});

  final int quantity;

  @override
  List<Object> get props => [quantity];
}

class FridgeFormExpirationDateChanged extends FridgeFormEvent {
  const FridgeFormExpirationDateChanged({this.expirationDate});

  final DateTime? expirationDate;

  @override
  List<Object?> get props => [expirationDate];
}

class FridgeFormProductCreated extends FridgeFormEvent {
  const FridgeFormProductCreated({
    required this.product,
    required this.categories,
  });

  final Product product;
  final List<Category> categories;

  @override
  List<Object> get props => [product, categories];
}
