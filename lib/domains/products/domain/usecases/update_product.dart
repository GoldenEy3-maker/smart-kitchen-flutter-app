import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";

class UpdateProduct implements UseCase<Product, UpdateProductParams> {
  const UpdateProduct({required this._repository});

  final ProductsRepository _repository;

  @override
  Future<Either<Failure, Product>> call(UpdateProductParams params) {
    return _repository.updateProduct(params);
  }
}
