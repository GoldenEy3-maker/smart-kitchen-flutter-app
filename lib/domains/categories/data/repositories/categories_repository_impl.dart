import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/domains/categories/data/data_sources/data_sources.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/params/params.dart";

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl({required this._localDataSource});

  final CategoriesLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    final result = await _localDataSource.getCategories();
    return result.fold(
      Left,
      (categories) =>
          Right(categories.map((category) => category.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Category>> createCategory(
    CreateCategoryParams params,
  ) async {
    final result = await _localDataSource.createCategory(params);
    return result.fold(Left, (category) => Right(category.toEntity()));
  }

  @override
  Future<Either<Failure, Category>> updateCategory(
    UpdateCategoryParams params,
  ) async {
    final result = await _localDataSource.updateCategory(params);
    return result.fold(Left, (category) => Right(category.toEntity()));
  }

  @override
  Future<Either<Failure, void>> deleteCategory(
    DeleteCategoryParams params,
  ) async {
    final result = await _localDataSource.deleteCategory(params);
    return result;
  }
}
