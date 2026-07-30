import "package:smart_kitchen_flutter_app/shared/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";

sealed class OpenProductFormResultEvent {
  const OpenProductFormResultEvent({required this.categories});

  final List<Category> categories;
}

class OpenProductFormResultEventDeleted extends OpenProductFormResultEvent {
  const OpenProductFormResultEventDeleted({
    required super.categories,
    required this.product,
  });

  final Product product;
}

class OpenProductFormResultEventCreated extends OpenProductFormResultEvent {
  const OpenProductFormResultEventCreated({
    required super.categories,
    required this.product,
  });

  final Product product;
}

class OpenProductFormResultEventUpdated extends OpenProductFormResultEvent {
  const OpenProductFormResultEventUpdated({
    required super.categories,
    required this.product,
  });

  final Product product;
}

class OpenProductFormResultEventReturned extends OpenProductFormResultEvent {
  const OpenProductFormResultEventReturned({required super.categories});
}
