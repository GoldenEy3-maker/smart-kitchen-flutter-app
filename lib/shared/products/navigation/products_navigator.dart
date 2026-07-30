import "package:smart_kitchen_flutter_app/shared/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/products/navigation/open_product_form_result_event.dart";

abstract interface class ProductsNavigator {
  Future<OpenProductFormResultEvent?> openProductForm({Product? product});
}
