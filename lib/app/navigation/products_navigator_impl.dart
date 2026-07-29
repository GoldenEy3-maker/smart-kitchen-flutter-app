import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";

class ProductsNavigatorImpl implements ProductsNavigator {
  ProductsNavigatorImpl({required this._router});

  final AppRouter _router;

  @override
  Future<OpenProductFormResultEvent?> openProductForm({
    Product? product,
  }) async {
    return _router.push(ProductFormRoute(product: product));
  }
}
