import "package:hive_ce/hive.dart";
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
      return Right(
        categories
            .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
            .toList(),
      );
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
      await categoriesBox.put(newCategory.id, newCategory.toJson());
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
      final existsCategory = categoriesBox.values
          .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
          .firstWhere((category) => category.id == params.id);

      final newCategory = CategoryModel(
        id: existsCategory.id,
        label: params.label ?? existsCategory.label,
        iconKey: params.iconKey ?? existsCategory.iconKey,
      );
      await categoriesBox.put(newCategory.id, newCategory.toJson());
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

  Future<Box<dynamic>> _openCategoriesBox() async {
    if (Hive.isBoxOpen(CategoriesLocalDataSourceBoxName.categories.name)) {
      return Hive.box(CategoriesLocalDataSourceBoxName.categories.name);
    }

    return Hive.openBox(CategoriesLocalDataSourceBoxName.categories.name);
  }
}
