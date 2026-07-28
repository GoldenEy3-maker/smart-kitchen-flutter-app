import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/features/products/params/params.dart";

class DeleteProduct implements UseCase<void, DeleteProductParams> {
  DeleteProduct({required this._repository});

  final ProductRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) {
    return _repository.deleteProduct(params);
  }
}
