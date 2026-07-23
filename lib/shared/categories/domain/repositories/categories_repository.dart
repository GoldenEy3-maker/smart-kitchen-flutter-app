import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

abstract interface class CategoriesRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, Category>> createCategory(CreateCategoryParams params);
  Future<Either<Failure, Category>> updateCategory(UpdateCategoryParams params);
  Future<Either<Failure, void>> deleteCategory(DeleteCategoryParams params);
}
