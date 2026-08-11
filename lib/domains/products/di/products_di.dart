import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/products/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/products/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerProductsDI() {
  getIt.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(talker: getIt.get<Talker>()),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      localDataSource: getIt.get<ProductsLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(repository: getIt.get<ProductsRepository>()),
  );

  getIt.registerLazySingleton<CreateProduct>(
    () => CreateProduct(repository: getIt.get<ProductsRepository>()),
  );

  getIt.registerLazySingleton<UpdateProduct>(
    () => UpdateProduct(repository: getIt.get<ProductsRepository>()),
  );

  getIt.registerLazySingleton<DeleteProduct>(
    () => DeleteProduct(repository: getIt.get<ProductsRepository>()),
  );
}
