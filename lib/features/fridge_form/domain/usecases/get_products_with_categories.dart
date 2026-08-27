import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/categories/error/error.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";
import "package:talker_flutter/talker_flutter.dart";

class GetProductsWithCategories
    implements UseCase<List<ProductWithCategory>, NoParams> {
  const GetProductsWithCategories({
    required this._getProducts,
    required this._getCategories,
    required this._talker,
  });

  final GetProducts _getProducts;
  final GetCategories _getCategories;
  final Talker _talker;

  @override
  Future<Either<Failure, List<ProductWithCategory>>> call(
    NoParams params,
  ) async {
    final (categoriesResult, productsResult) = await (
      _getCategories(const NoParams()),
      _getProducts(const NoParams()),
    ).wait;

    if (categoriesResult.isRight() && productsResult.isRight()) {
      final categories = categoriesResult.rightOrNull!;
      final products = productsResult.rightOrNull!;

      try {
        final items = products.map((product) {
          final category = categories.firstWhere(
            (category) => category.id == product.categoryId,
          );

          return ProductWithCategory(product: product, category: category);
        }).toList();

        return Right(items);
        // ignore: avoid_catches_without_on_clauses - firstWhere throws StateError when a product's category is missing; the UI only needs a Failure
      } catch (e, st) {
        _talker.error("getProductsWithCategories failed", e, st);
        return Left(const CategoriesNotFoundFailure());
      }
    }

    return Left(
      categoriesResult.leftOrNull ??
          productsResult.leftOrNull ??
          const UnknownFailure(),
    );
  }
}
