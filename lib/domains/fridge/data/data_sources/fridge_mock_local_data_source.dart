import "package:smart_kitchen_flutter_app/core/error/failure.dart";

import "package:smart_kitchen_flutter_app/core/utils/either.dart";

import "package:smart_kitchen_flutter_app/domains/fridge/data/models/fridge_product_model.dart";

import "fridge_local_data_source.dart";

class FridgeMockLocalDataSource implements FridgeLocalDataSource {
  @override
  Future<Either<Failure, List<FridgeProductModel>>> getFridgeProducts() async {
    return Right([
      FridgeProductModel(
        id: "1",
        productId: "1",
        quantity: 1,
        expirationDate: DateTime.now().add(const Duration(days: 1)),
      ),
    ]);
  }
}
