import "package:hive/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/products/data/models/models.dart";

abstract interface class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}

enum ProductLocalDataSourceBoxName { products }

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final productsBox = await _openProductsBox();
      final products = productsBox.values.toList();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<Box<ProductModel>> _openProductsBox() =>
      Hive.openBox<ProductModel>(ProductLocalDataSourceBoxName.products.name);
}
