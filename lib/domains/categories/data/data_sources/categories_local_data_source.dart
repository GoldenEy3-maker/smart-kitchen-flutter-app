import "package:hive_ce/hive.dart";
import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/models/models.dart";
import "package:smart_kitchen_flutter_app/domains/categories/error/error.dart";
import "package:smart_kitchen_flutter_app/domains/categories/params/params.dart";
import "package:talker_flutter/talker_flutter.dart";

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
  CategoriesLocalDataSourceImpl({required this._talker});

  final Talker _talker;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categoriesBox = await _openCategoriesBox();
      final categories = categoriesBox.values
          .cast<Map<dynamic, dynamic>>()
          .toList()
          .reversed
          .toList();
      return Right(
        categories
            .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
            .toList(),
      );
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("getCategories failed", e, st);
      return Left(const CategoriesReadCacheFailure());
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
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("createCategory failed", e, st);
      return Left(const CategoriesCreateFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> updateCategory(
    UpdateCategoryParams params,
  ) async {
    try {
      final categoriesBox = await _openCategoriesBox();
      final existsCategory = categoriesBox.values
          .cast<Map<dynamic, dynamic>>()
          .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
          .firstWhere((category) => category.id == params.id);

      final newCategory = CategoryModel(
        id: existsCategory.id,
        label: params.label ?? existsCategory.label,
        iconKey: params.iconKey ?? existsCategory.iconKey,
      );
      await categoriesBox.put(newCategory.id, newCategory.toJson());
      return Right(newCategory);
    } on Exception catch (e, st) {
      _talker.error("updateCategory failed", e, st);
      return Left(const CategoriesNotFoundFailure());
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("updateCategory failed", e, st);
      return Left(const CategoriesUpdateFailure());
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
      // ignore: avoid_catches_without_on_clauses - we want to catch all errors and just log them cuz for interface it does not matter what error is thrown
    } catch (e, st) {
      _talker.error("deleteCategory failed", e, st);
      return Left(const CategoriesDeleteFailure());
    }
  }

  Future<Box<dynamic>> _openCategoriesBox() async {
    if (Hive.isBoxOpen(CategoriesLocalDataSourceBoxName.categories.name)) {
      return Hive.box(CategoriesLocalDataSourceBoxName.categories.name);
    }

    return Hive.openBox(CategoriesLocalDataSourceBoxName.categories.name);
  }
}
