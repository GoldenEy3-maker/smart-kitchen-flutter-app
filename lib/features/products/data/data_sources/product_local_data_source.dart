import "package:hive/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/features/products/data/models/models.dart";

abstract interface class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  // Future<Either<Failure, CategoryModel>> createCategory(
  //   CreateCategoryModel category,
  // );
  // Future<Either<Failure, CategoryModel>> updateCategory(
  //   UpdateCategoryModel category,
  // );
  // Future<Either<Failure, bool>> deleteCategory(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categoriesBox = _openCategoriesBox();
      return Right(categoriesBox.values.toList());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final productsBox = _openProductsBox();
      return Right(productsBox.values.toList());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, CategoryModel>> createCategory(CreateCategoryModel category) async {
  //   try {
  //     final categoriesBox = await _openCategoriesBox();
  //     final newCategory = CategoryModel(
  //       id: (categoriesBox.values.length + 1).toString(),
  //       label: category.label,
  //       iconKey: category.iconKey,
  //     );
  //     await categoriesBox.add(newCategory);
  //     return Right(newCategory);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, CategoryModel>> updateCategory(UpdateCategoryModel updateCategory) async {
  //   try {
  //     final categoriesBox = await _openCategoriesBox();
  //     final category = categoriesBox.values.firstWhere((c) => c.id == updateCategory.id);
  //     if (updateCategory.label != null) {
  //       category.label = updateCategory.label!;
  //     }
  //     await categoriesBox.put(category.id, category);
  //     return Right(category);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString()));
  //   }
  // }

  Box<CategoryModel> _openCategoriesBox() =>
      Hive.box<CategoryModel>("categories");
  Box<ProductModel> _openProductsBox() => Hive.box<ProductModel>("products");
}
