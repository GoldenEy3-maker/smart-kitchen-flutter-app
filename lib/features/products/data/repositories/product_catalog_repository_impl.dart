import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/products/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/product.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/repositories/repositories.dart";

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource _localDataSource;

  ProductRepositoryImpl({required this._localDataSource});

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
