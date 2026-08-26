import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/data/models/models.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/error/error.dart";
import "package:talker_flutter/talker_flutter.dart";

// ignore: one_member_abstracts - this is a contract for the data source may extend with more methods in the future
abstract interface class FridgeLocalDataSource {
  Future<Either<Failure, List<FridgeProductModel>>> getFridgeProducts();
}

enum FridgeLocalDataSourceBoxName { fridgeProducts }

class FridgeLocalDataSourceImpl implements FridgeLocalDataSource {
  FridgeLocalDataSourceImpl({required this._talker});

  final Talker _talker;

  @override
  Future<Either<Failure, List<FridgeProductModel>>> getFridgeProducts() async {
    try {
      final fridgeBox = await _getFridgeBox();
      final fridgeProducts = fridgeBox.values
          .cast<Map<dynamic, dynamic>>()
          .toList()
          .reversed
          .map((e) => FridgeProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return Right(fridgeProducts);
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("getFridgeProducts failed", e, st);
      return Left(const FridgeReadProductsCacheFailure());
    }
  }

  Future<Box<dynamic>> _getFridgeBox() async {
    if (Hive.isBoxOpen(FridgeLocalDataSourceBoxName.fridgeProducts.name)) {
      return Hive.box(FridgeLocalDataSourceBoxName.fridgeProducts.name);
    }

    return Hive.openBox(FridgeLocalDataSourceBoxName.fridgeProducts.name);
  }
}
