import "package:dartz/dartz.dart";
import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/entities/entities.dart";

// ignore: one_member_abstracts - this is a contract for the repository may extend with more methods in the future
abstract interface class FridgeRepository {
  Future<Either<Failure, List<FridgeProduct>>> getFridgeProducts();
}
