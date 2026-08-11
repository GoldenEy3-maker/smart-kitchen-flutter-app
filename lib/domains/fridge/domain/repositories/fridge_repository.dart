import "package:dartz/dartz.dart";
import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/entities/entities.dart";

abstract interface class FridgeRepository {
  Future<Either<Failure, List<FridgeProduct>>> getFridgeProducts();
}
