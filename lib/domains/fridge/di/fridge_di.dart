import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerFridgeDI() {
  getIt.registerLazySingleton<FridgeLocalDataSource>(
    () => FridgeLocalDataSourceImpl(talker: getIt.get<Talker>()),
  );
  getIt.registerLazySingleton<FridgeRepository>(
    () => FridgeRepositoryImpl(
      localDataSource: getIt.get<FridgeLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetFridgeProducts>(
    () => GetFridgeProducts(repository: getIt.get<FridgeRepository>()),
  );
}
