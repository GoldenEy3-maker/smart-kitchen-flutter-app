import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/products/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/product.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({required this._localDataSource});
  final ProductsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final result = await _localDataSource.getProducts();
    return result.fold(
      Left,
      (products) =>
          Right(products.map((product) => product.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Product>> createProduct(
    CreateProductParams params,
  ) async {
    final result = await _localDataSource.createProduct(params);
    return result.fold(Left, (product) => Right(product.toEntity()));
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
    UpdateProductParams params,
  ) async {
    final result = await _localDataSource.updateProduct(params);
    return result.fold(Left, (product) => Right(product.toEntity()));
  }

  @override
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params) {
    return _localDataSource.deleteProduct(params);
  }
}
