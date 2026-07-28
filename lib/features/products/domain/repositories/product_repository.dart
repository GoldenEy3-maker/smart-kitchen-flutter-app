import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/params/params.dart";

abstract interface class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> createProduct(CreateProductParams params);
  Future<Either<Failure, Product>> updateProduct(UpdateProductParams params);
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
}
