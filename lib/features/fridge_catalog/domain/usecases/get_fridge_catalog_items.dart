import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/error/fridge_failure.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/entities/entities.dart";
import "package:talker_flutter/talker_flutter.dart";

class GetFridgeCatalogItems
    implements UseCase<List<FridgeProductItem>, NoParams> {
  const GetFridgeCatalogItems({
    required this._getFridgeProducts,
    required this._getProducts,
    required this._talker,
  });

  final GetFridgeProducts _getFridgeProducts;
  final GetProducts _getProducts;
  final Talker _talker;

  @override
  Future<Either<Failure, List<FridgeProductItem>>> call(NoParams params) async {
    final (fridgeProductsResult, productsResult) = await (
      _getFridgeProducts(const NoParams()),
      _getProducts(const NoParams()),
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
        // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
      } catch (e, st) {
        _talker.error("getFridgeCatalogItems failed", e, st);
        /**
         * Handle the case when a product is not found in the products list 
         * and firstWhere throws an StateError exception.
         */
        return Left(const FridgeProductNotFoundFailure());
      }
    }

    return Left(
      fridgeProductsResult.leftOrNull ??
          productsResult.leftOrNull ??
          const UnknownFailure(),
    );
  }
}
