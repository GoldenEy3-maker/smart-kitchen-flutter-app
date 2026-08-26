import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/params/params.dart";

class CreateCategory implements UseCase<Category, CreateCategoryParams> {
  CreateCategory({required this._repository});
  final CategoriesRepository _repository;

  @override
  Future<Either<Failure, Category>> call(CreateCategoryParams params) {
    return _repository.createCategory(params);
  }
}
