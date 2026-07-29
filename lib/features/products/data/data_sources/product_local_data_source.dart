import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/products/data/models/models.dart";
import "package:smart_kitchen_flutter_app/features/products/error/error.dart";
import "package:smart_kitchen_flutter_app/features/products/params/params.dart";
import "package:talker_flutter/talker_flutter.dart";

abstract interface class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> createProduct(
    CreateProductParams params,
  );
  Future<Either<Failure, ProductModel>> updateProduct(
    UpdateProductParams params,
  );
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
}

enum ProductLocalDataSourceBoxName { products }

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl({required this._talker});

  final Talker _talker;

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final productsBox = await _openProductsBox();
      final products = productsBox.values.toList().reversed.toList();
      return Right(
        products
            .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
            .toList(),
      );
    } catch (e, st) {
      _talker.error("getProducts failed", e, st);
      return Left(ProductsReadCacheFailure());
    }
  }

  Future<Box<dynamic>> _openProductsBox() async {
    if (Hive.isBoxOpen(ProductLocalDataSourceBoxName.products.name)) {
      return Hive.box(ProductLocalDataSourceBoxName.products.name);
    }
    return Hive.openBox(ProductLocalDataSourceBoxName.products.name);
  }

  @override
  Future<Either<Failure, ProductModel>> createProduct(
    CreateProductParams params,
  ) async {
    try {
      final productsBox = await _openProductsBox();
      final newProduct = ProductModel(
        id: (productsBox.values.length + 1).toString(),
        name: params.name,
        iconKey: params.iconKey,
        unit: params.unit,
        categoryId: params.categoryId,
      );
      await productsBox.put(newProduct.id, newProduct.toJson());
      return Right(newProduct);
    } catch (e, st) {
      _talker.error("createProduct failed", e, st);
      return Left(ProductsCreateCacheFailure());
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct(
    UpdateProductParams params,
  ) async {
    try {
      final productsBox = await _openProductsBox();
      final existsProduct = productsBox.values
          .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
          .firstWhere((p) => p.id == params.id);
      final newProduct = ProductModel(
        id: existsProduct.id,
        name: params.name ?? existsProduct.name,
        iconKey: params.iconKey ?? existsProduct.iconKey,
        unit: params.unit ?? existsProduct.unit,
        categoryId: params.categoryId ?? existsProduct.categoryId,
      );
      await productsBox.put(newProduct.id, newProduct.toJson());
      return Right(newProduct);
    } on StateError catch (e, st) {
      _talker.error("updateProduct failed", e, st);
      return Left(ProductsNotFoundFailure());
    } catch (e, st) {
      _talker.error("updateProduct failed", e, st);
      return Left(ProductsUpdateCacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(
    DeleteProductParams params,
  ) async {
    try {
      final productsBox = await _openProductsBox();
      await productsBox.delete(params.id);
      return Right(null);
    } catch (e, st) {
      _talker.error("deleteProduct failed", e, st);
      return Left(ProductsDeleteCacheFailure());
    }
  }
}
