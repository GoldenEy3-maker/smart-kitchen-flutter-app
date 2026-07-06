import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/models/models.dart";

abstract interface class ProductCatalogLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
