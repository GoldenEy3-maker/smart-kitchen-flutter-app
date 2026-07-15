import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/category.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/product.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/repositories/repositories.dart";

class ProductCatalogRepositoryImpl implements ProductCatalogRepository {
  final ProductCatalogLocalDataSource _localDataSource;

  ProductCatalogRepositoryImpl({required this._localDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    final result = await _localDataSource.getCategories();
    return result.fold(
      (failure) => Left(failure),
      (categories) =>
          Right(categories.map((category) => category.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final result = await _localDataSource.getProducts();
    return result.fold(
      (failure) => Left(failure),
      (products) =>
          Right(products.map((product) => product.toEntity()).toList()),
    );
  }
}
