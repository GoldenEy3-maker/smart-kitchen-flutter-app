import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/entities/fridge_product.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/repositories/repositories.dart";

class FridgeRepositoryImpl implements FridgeRepository {
  FridgeRepositoryImpl({required this._localDataSource});

  final FridgeLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<FridgeProduct>>> getFridgeProducts() async {
    final result = await _localDataSource.getFridgeProducts();
    return result.fold(
      Left,
      (products) =>
          Right(products.map((product) => product.toEntity()).toList()),
    );
  }
}
