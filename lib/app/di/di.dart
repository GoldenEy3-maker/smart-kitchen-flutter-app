import "package:smart_kitchen_flutter_app/features/product_form/di/di.dart";
import "package:smart_kitchen_flutter_app/shared/categories/di/di.dart";
import "package:smart_kitchen_flutter_app/shared/products/di/di.dart";

import "core_scope.dart";

Future<void> registerAppDI() async {
  await registerCoreScopeDI();
  registerCategoriesDI();
  registerProductsDI();
  registerProductFormDI();
}
