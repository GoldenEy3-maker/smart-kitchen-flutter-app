import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/shared/products/domain/usecases/usecases.dart";

void registerProductFormDI() {
  getIt.registerLazySingleton<GetCategoriesWithProductsCount>(
    () => GetCategoriesWithProductsCount(
      getProducts: getIt.get<GetProducts>(),
      getCategories: getIt.get<GetCategories>(),
    ),
  );
}
