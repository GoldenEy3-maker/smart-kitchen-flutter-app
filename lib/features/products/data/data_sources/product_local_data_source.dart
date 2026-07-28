import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/products/data/models/models.dart";
import "package:smart_kitchen_flutter_app/features/products/error/error.dart";
import "package:talker_flutter/talker_flutter.dart";

abstract interface class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}

enum ProductLocalDataSourceBoxName { products }

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl({required this._talker});

  final Talker _talker;

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final productsBox = await _openProductsBox();
      final products = productsBox.values.toList();
      return Right(products.map((p) => ProductModel.fromJson(p)).toList());
    } catch (e, st) {
      _talker.error("ProductLocalDataSourceImpl.getProducts failed", e, st);
      return Left(ProductsReadCacheFailure());
    }
  }

  Future<Box<dynamic>> _openProductsBox() async {
    if (Hive.isBoxOpen(ProductLocalDataSourceBoxName.products.name)) {
      return Hive.box(ProductLocalDataSourceBoxName.products.name);
    }
    return Hive.openBox(ProductLocalDataSourceBoxName.products.name);
  }
}
