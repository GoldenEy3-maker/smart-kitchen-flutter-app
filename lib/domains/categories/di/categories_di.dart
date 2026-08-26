import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerCategoriesDI() {
  getIt
    ..registerLazySingleton<CategoriesLocalDataSource>(
      () => CategoriesLocalDataSourceImpl(talker: getIt.get<Talker>()),
    )
    ..registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
        localDataSource: getIt.get<CategoriesLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<GetCategories>(
      () => GetCategories(repository: getIt.get<CategoriesRepository>()),
    )
    ..registerLazySingleton<DeleteCategory>(
      () => DeleteCategory(repository: getIt.get<CategoriesRepository>()),
    )
    ..registerLazySingleton<UpdateCategory>(
      () => UpdateCategory(repository: getIt.get<CategoriesRepository>()),
    )
    ..registerLazySingleton<CreateCategory>(
      () => CreateCategory(repository: getIt.get<CategoriesRepository>()),
    );
}
