import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/domains/products/data/models/models.dart";
import "package:smart_kitchen_flutter_app/domains/products/error/error.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";
import "package:talker_flutter/talker_flutter.dart";

abstract interface class ProductsLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> createProduct(
    CreateProductParams params,
  );
  Future<Either<Failure, ProductModel>> updateProduct(
    UpdateProductParams params,
  );
  Future<Either<Failure, void>> deleteProduct(DeleteProductParams params);
}

enum ProductsLocalDataSourceBoxName { products }

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  ProductsLocalDataSourceImpl({required this._talker});

  final Talker _talker;

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final productsBox = await _openProductsBox();
      final products = productsBox.values
          .cast<Map<dynamic, dynamic>>()
          .toList()
          .reversed
          .toList();
      return Right(
        products
            .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
            .toList(),
      );
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("getProducts failed", e, st);
      return Left(const ProductsReadCacheFailure());
    }
  }

  Future<Box<dynamic>> _openProductsBox() async {
    if (Hive.isBoxOpen(ProductsLocalDataSourceBoxName.products.name)) {
      return Hive.box(ProductsLocalDataSourceBoxName.products.name);
    }
    return Hive.openBox(ProductsLocalDataSourceBoxName.products.name);
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
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("createProduct failed", e, st);
      return Left(const ProductsCreateCacheFailure());
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct(
    UpdateProductParams params,
  ) async {
    try {
      final productsBox = await _openProductsBox();
      final existsProduct = productsBox.values
          .cast<Map<dynamic, dynamic>>()
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
    } on Exception catch (e, st) {
      _talker.error("updateProduct failed", e, st);
      return Left(const ProductsNotFoundFailure());
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("updateProduct failed", e, st);
      return Left(const ProductsUpdateCacheFailure());
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
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("deleteProduct failed", e, st);
      return Left(const ProductsDeleteCacheFailure());
    }
  }
}
