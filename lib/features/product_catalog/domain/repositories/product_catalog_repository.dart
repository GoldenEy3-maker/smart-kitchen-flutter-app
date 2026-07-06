import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";

abstract interface class ProductCatalogRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Category>>> getCategories();
}
