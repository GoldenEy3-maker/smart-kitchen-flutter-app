import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerCategoriesDI() {
  getIt.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(talker: getIt.get<Talker>()),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      localDataSource: getIt.get<CategoriesLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(repository: getIt.get<CategoriesRepository>()),
  );
  getIt.registerLazySingleton<DeleteCategory>(
    () => DeleteCategory(repository: getIt.get<CategoriesRepository>()),
  );
  getIt.registerLazySingleton<UpdateCategory>(
    () => UpdateCategory(repository: getIt.get<CategoriesRepository>()),
  );
  getIt.registerLazySingleton<CreateCategory>(
    () => CreateCategory(repository: getIt.get<CategoriesRepository>()),
  );
}
