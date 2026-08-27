import "package:smart_kitchen_flutter_app/app/di/core_scope.dart";
import "package:smart_kitchen_flutter_app/domains/categories/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/products/di/di.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/di/fridge_catalog_di.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/di/di.dart";
import "package:smart_kitchen_flutter_app/features/product_form/di/di.dart";

Future<void> registerAppDI() async {
  await registerCoreScopeDI();
  registerCategoriesDI();
  registerProductsDI();
  registerProductFormDI();
  registerFridgeDI();
  registerFridgeCatalogDI();
  registerFridgeFormDI();
}
