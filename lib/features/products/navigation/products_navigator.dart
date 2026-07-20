import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

abstract interface class ProductsNavigator {
  void openProductForm({Product? product});
}
