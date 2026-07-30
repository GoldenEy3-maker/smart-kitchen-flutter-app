import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/products/domain/usecases/usecases.dart";

class GetCategoriesWithProductsCount
    implements UseCase<List<CategoryWithProductsCount>, NoParams> {
  GetCategoriesWithProductsCount({
    required this._getProducts,
    required this._getCategories,
  });

  final GetProducts _getProducts;
  final GetCategories _getCategories;

  @override
  Future<Either<Failure, List<CategoryWithProductsCount>>> call(
    NoParams params,
  ) async {
    final (categoriesResult, productsResult) = await (
      _getCategories(NoParams()),
      _getProducts(NoParams()),
    ).wait;

    if (categoriesResult.isRight() && productsResult.isRight()) {
      final categories = categoriesResult.rightOrNull!;
      final products = productsResult.rightOrNull!;

      return Right(
        categories
            .map(
              (category) => CategoryWithProductsCount(
                id: category.id,
                label: category.label,
                iconKey: category.iconKey,
                productsCount: products
                    .where((product) => product.categoryId == category.id)
                    .length,
              ),
            )
            .toList(),
      );
    }

    return Left(
      categoriesResult.leftOrNull ??
          productsResult.leftOrNull ??
          UnknownFailure(),
    );
  }
}
