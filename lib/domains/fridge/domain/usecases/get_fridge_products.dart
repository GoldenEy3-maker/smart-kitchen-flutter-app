import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/repositories/repositories.dart";

class GetFridgeProducts implements UseCase<List<FridgeProduct>, NoParams> {
  const GetFridgeProducts({required this._repository});

  final FridgeRepository _repository;

  @override
  Future<Either<Failure, List<FridgeProduct>>> call(NoParams params) {
    return _repository.getFridgeProducts();
  }
}
