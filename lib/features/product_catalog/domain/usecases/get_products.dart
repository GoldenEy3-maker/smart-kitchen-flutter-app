import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/repositories/repositories.dart";

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductCatalogRepository _repository;

  const GetProducts({required this._repository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return _repository.getProducts();
  }
}
