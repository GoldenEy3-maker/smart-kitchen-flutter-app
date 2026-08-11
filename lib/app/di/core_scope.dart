import "package:smart_kitchen_flutter_app/app/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/logging/logging.dart";
import "package:smart_kitchen_flutter_app/core/storage/storage.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/navigation/fridge_navigator.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/navigation.dart";
import "package:talker_flutter/talker_flutter.dart";

Future<void> registerCoreScopeDI() async {
  getIt.registerLazySingleton<Talker>(() => TalkerFactory().create());

  final hiveStoragePath = await HiveInitializer().init();

  getIt.get<Talker>().info("Hive initialized at $hiveStoragePath");

  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerLazySingleton<ProductsNavigator>(
    () => ProductsNavigatorImpl(router: getIt.get<AppRouter>()),
  );
  getIt.registerLazySingleton<FridgeNavigator>(
    () => FridgeNavigatorImpl(router: getIt.get<AppRouter>()),
  );
  getIt.registerLazySingleton<AppTheme>(() => AppTheme());
}
