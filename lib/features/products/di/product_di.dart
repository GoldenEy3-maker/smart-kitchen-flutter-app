import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/features/products/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/features/products/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";

void registerProductDI() {
  getIt.registerLazySingleton<ProductLocalDataSource>(
    // () => ProductMockLocalDataSource(),
    () => ProductLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      localDataSource: getIt.get<ProductLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(repository: getIt.get<ProductRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriesWithProductsCount>(
    () => GetCategoriesWithProductsCount(
      productRepository: getIt.get<ProductRepository>(),
      getCategories: getIt.get<GetCategories>(),
    ),
  );
}
