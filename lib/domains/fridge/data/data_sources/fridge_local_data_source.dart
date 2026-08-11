import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/data/models/models.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/error/error.dart";
import "package:talker_flutter/talker_flutter.dart";

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
          .toList()
          .reversed
          .map((e) => FridgeProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return Right(fridgeProducts);
    } catch (e, st) {
      _talker.error("getFridgeProducts failed", e, st);
      return Left(FridgeReadProductsCacheFailure());
    }
  }

  Future<Box<dynamic>> _getFridgeBox() async {
    if (Hive.isBoxOpen(FridgeLocalDataSourceBoxName.fridgeProducts.name)) {
      return Hive.box(FridgeLocalDataSourceBoxName.fridgeProducts.name);
    }

    return Hive.openBox(FridgeLocalDataSourceBoxName.fridgeProducts.name);
  }
}
