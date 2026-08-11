import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";

class CreateProduct implements UseCase<Product, CreateProductParams> {
  CreateProduct({required this._repository});

  final ProductsRepository _repository;

  @override
  Future<Either<Failure, Product>> call(CreateProductParams params) {
    return _repository.createProduct(params);
  }
}
