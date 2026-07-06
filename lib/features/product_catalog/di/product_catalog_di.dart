import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/usecases/usecases.dart";

void registerProductCatalogDI() {
  getIt.registerLazySingleton<ProductCatalogLocalDataSource>(
    () => ProductCatalogMockLocalDataSource(),
  );
  getIt.registerLazySingleton<ProductCatalogRepository>(
    () => ProductCatalogRepositoryImpl(
      localDataSource: getIt.get<ProductCatalogLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(repository: getIt.get<ProductCatalogRepository>()),
  );
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(repository: getIt.get<ProductCatalogRepository>()),
  );
}
