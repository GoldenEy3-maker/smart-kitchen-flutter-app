import "package:hive/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/shared/categories/data/models/models.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

abstract interface class CategoriesLocalDataSource {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, CategoryModel>> createCategory(
    CreateCategoryParams params,
  );
  Future<Either<Failure, CategoryModel>> updateCategory(
    UpdateCategoryParams params,
  );
  Future<Either<Failure, void>> deleteCategory(DeleteCategoryParams params);
}

enum CategoriesLocalDataSourceBoxName { categories }

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categoriesBox = await _openCategoriesBox();
      final categories = categoriesBox.values.toList();
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> createCategory(
    CreateCategoryParams params,
  ) async {
    try {
      final categoriesBox = await _openCategoriesBox();
      final newCategory = CategoryModel(
        id: (categoriesBox.values.length + 1).toString(),
        label: params.label,
        iconKey: params.iconKey,
      );
      await categoriesBox.add(newCategory);
      return Right(newCategory);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> updateCategory(
    UpdateCategoryParams params,
  ) async {
    try {
      final categoriesBox = await _openCategoriesBox();
      final existsCategory = categoriesBox.values.firstWhere(
        (c) => c.id == params.id,
      );
      final newCategory = CategoryModel(
        id: existsCategory.id,
        label: params.label ?? existsCategory.label,
        iconKey: params.iconKey ?? existsCategory.iconKey,
      );
      await categoriesBox.put(newCategory.id, newCategory);
      return Right(newCategory);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(
    DeleteCategoryParams params,
  ) async {
    try {
      final categoriesBox = await _openCategoriesBox();
      await categoriesBox.delete(params.id);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<Box<CategoryModel>> _openCategoriesBox() {
    return Hive.openBox<CategoryModel>(
      CategoriesLocalDataSourceBoxName.categories.name,
    );
  }
}
