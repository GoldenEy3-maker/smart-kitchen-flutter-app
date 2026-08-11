import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";

abstract interface class ProductsRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> createProduct(CreateProductParams params);
  Future<Either<Failure, Product>> updateProduct(UpdateProductParams params);
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
}
