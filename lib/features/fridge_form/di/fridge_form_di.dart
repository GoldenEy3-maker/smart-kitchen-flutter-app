import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerFridgeFormDI() {
  getIt.registerLazySingleton<GetProductsWithCategories>(
    () => GetProductsWithCategories(
      getProducts: getIt.get<GetProducts>(),
      getCategories: getIt.get<GetCategories>(),
      talker: getIt.get<Talker>(),
    ),
  );
}
