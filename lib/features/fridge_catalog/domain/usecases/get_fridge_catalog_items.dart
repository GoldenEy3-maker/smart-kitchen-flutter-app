import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/error/fridge_failure.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/entities/entities.dart";

class GetFridgeCatalogItems
    implements UseCase<List<FridgeProductItem>, NoParams> {
  const GetFridgeCatalogItems({
    required this._getFridgeProducts,
    required this._getProducts,
  });

  final GetFridgeProducts _getFridgeProducts;
  final GetProducts _getProducts;

  @override
  Future<Either<Failure, List<FridgeProductItem>>> call(NoParams params) async {
    final (fridgeProductsResult, productsResult) = await (
      _getFridgeProducts(NoParams()),
      _getProducts(NoParams()),
    ).wait;

    if (fridgeProductsResult.isRight() && productsResult.isRight()) {
      final fridgeProducts = fridgeProductsResult.rightOrNull!;
      final products = productsResult.rightOrNull!;

      try {
        final items = fridgeProducts.map((fridgeProduct) {
          final product = products.firstWhere(
            (product) => product.id == fridgeProduct.productId,
          );

          return FridgeProductItem(
            id: fridgeProduct.id,
            product: product,
            quantity: fridgeProduct.quantity,
            expirationDate: fridgeProduct.expirationDate,
          );
        }).toList();

        return Right(items);
      } catch (_) {
        /**
         * Handle the case when a product is not found in the products list and firstWhere throws an StateError exception.
         */
        return Left(const FridgeProductNotFoundFailure());
      }
    }

    return Left(
      fridgeProductsResult.leftOrNull ??
          productsResult.leftOrNull ??
          UnknownFailure(),
    );
  }
}
