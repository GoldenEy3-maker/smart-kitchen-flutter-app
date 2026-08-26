import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/open_product_form_result_event.dart";

// ignore: one_member_abstracts - this is a contract for the navigator may extend with more methods in the future
abstract interface class ProductsNavigator {
  Future<OpenProductFormResultEvent?> openProductForm({Product? product});
}
