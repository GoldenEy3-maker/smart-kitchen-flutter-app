import "package:smart_kitchen_flutter_app/features/product_catalog/di/di.dart";

import "core_scope.dart";

Future<void> registerAppDI() async {
  await registerCoreScopeDI();
  registerProductCatalogDI();
}
