import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/repositories/repositories.dart";

class GetCategories implements UseCase<List<Category>, NoParams> {
  final ProductRepository _repository;

  const GetCategories({required this._repository});

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return _repository.getCategories();
  }
}
