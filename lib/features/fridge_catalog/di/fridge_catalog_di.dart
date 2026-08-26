import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerFridgeCatalogDI() {
  getIt.registerLazySingleton<GetFridgeCatalogItems>(
    () => GetFridgeCatalogItems(
      getFridgeProducts: getIt.get<GetFridgeProducts>(),
      getProducts: getIt.get<GetProducts>(),
      talker: getIt.get<Talker>(),
    ),
  );
}
